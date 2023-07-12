# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a listas de preferencias.
module Api
  module V1
    class ListPrefsController < ApplicationController

      #acts_as_token_authentication_handler_for User, only: []

      # Obtem todas as listas de preferencias.
      #
      # @return [JSON] Lista de listas de preferencias em formato JSON.
      def index
        list_pref = ListPreference.all
        render json: array_serializer(list_pref), status: :ok
      end

      # Obtem uma lista de preferencias especifica pelo ID do usuario.
      #
      # @param user_id [Int] O ID do usuario.
      # @return [JSON] A lista de preferencias em formato JSON.
      # @raise [StandardError] Caso a lista de preferencias nao seja encontrada.
      def show
        list_pref = ListPreference.where('user_id = ?', params[:user_id])
        return_http = :ok
        return_http = :not_found if list_pref.empty?
        render json: array_serializer(list_pref), status: return_http
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Cria uma nova lista de preferencias.
      #
      # @param list_pref_params [String] Parametros da lista de preferencias a ser criada.
      # @option list_pref_params [Int] :user_id O ID do usuario da lista de preferencias.
      # @option list_pref_params [Int] :preference_id O ID da preferencia da lista.
      # @return [JSON] A lista de preferencias criada em formato JSON.
      # @raise [StandardError] Caso a lista de preferencias não possa ser criada.
      def create
        user = User.find_by(user_id: current_user.id)
        list_pref = ListPreference.new(list_pref_params)
        user_list = ListPreference.select{|usr_list_preference| usr_list_preference.user_id == user.id }
         
        list_pref.save!
        render json: list_pref, status: :created
        # return_http = :bad_request if user.list_pref.length() >=10
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Exclui uma lista de preferencias especifica pelo ID.
      #
      # @param id [Int] O ID da lista de preferencias a ser excluida.
      # @return [JSON] A lista de preferencias excluida em formato JSON.
      # @raise [StandardError] Caso a lista de preferencias nao possa ser excluida.
      def delete
        list_pref = ListPreference.find(params[:id])
        list_pref.destroy!
        render json: list_pref, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Exclui todas as listas de preferencias de um usuario especifico pelo ID.
      #
      # @param user_id [Int] O ID do usuario.
      # @return [JSON] A lista de preferencias excluida em formato JSON.
      # @raise [StandardError] Caso a lista de preferencias do usuario nao possa ser excluida.
      def delete_user_prefs
        list_pref = ListPreference.find(params[:user_id])
        ListPreference.where(user_id: list_pref.user_id).destroy_all
        render json: list_pref, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(list_pref)
        Panko::ArraySerializer.new(list_pref, each_serializer: ListPrefsSerializer).to_json
      end

      def serializer(list_pref)
        ListPrefsSerializer.new.serialize_to_json(list_pref)
      end

      # Define os parametros permitidos para a criacao da lista de preferencias.
      #
      # @return [String] Os parametros permitidos para a criacao da lista de preferencias.

      def list_pref_params
        params.require(:list_preference).permit(:user_id, :preference_id)
      end
    end
  end
end
