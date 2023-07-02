# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a preferencias.
module Api
  module V1
    class PreferenceController < ApplicationController
      # Obtém todas as preferências.
      #
      # @return [JSON] Lista de preferencias em formato JSON.
      def index
        preference = Preference.all
        render json: array_serializer(preference), status: :ok
      end

      # Obtem uma preferencia especifica pelo ID.
      #
      # @param id [Int] O ID da preferencia.
      # @return [JSON] A preferencia em formato JSON.
      # @raise [StandardError] Caso a preferencia nao seja encontrada.
      def show
        preference = Preference.find(params[:id])
        render json: serializer(preference), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Cria uma nova preferencia.
      #
      # @param preference_params [String] Parametros da preferencia a ser criada.
      # @option preference_params [String] :tipo O tipo da preferencia.
      # @option preference_params [String] :descricao A descricao da preferencia.
      # @return [JSON] A preferencia criada em formato JSON.
      # @raise [StandardError] Caso a preferencia nao possa ser criada.
      def create
        preference = Preference.new(preference_params)
        preference.save!
        render json: preference, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Exclui uma preferencia especifica pelo ID.
      #
      # @param id [Int] O ID da preferencia a ser excluida.
      # @return [JSON] A preferencia excluida em formato JSON.
      # @raise [StandardError] Caso a preferencia nao possa ser excluida.
      def delete
        preference = Preference.find(params[:id])
        preference.destroy!
        render json: preference, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Atualiza uma preferencia existente pelo ID.
      #
      # @param id [Int] O ID da preferencia a ser atualizada.
      # @param preference_params [String] Parametros da preferencia a serem atualizados.
      # @option preference_params [String] :tipo O tipo da preferencia.
      # @option preference_params [String] :descricao A descricao da preferencia.
      # @return [JSON] A preferencia atualizada em formato JSON.
      # @raise [StandardError] Caso a preferencia nao possa ser atualizada.
      def update
        preference = Preference.find(params[:id])
        preference.update!(preference_params)
        render json: preference, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(preferences)
        Panko::ArraySerializer.new(preferences, each_serializer: PreferenceSerializer).to_json
      end

      def serializer(preference)
        PreferenceSerializer.new.serialize_to_json(preference)
      end

      # Define os parametros permitidos para a criacao ou atualizacao da preferencia.
      #
      # @return [String] Os parametros permitidos para a criacao ou atualizacao da preferencia.
      def preference_params
        params.require(:preference).permit(:tipo, :descricao)
      end
    end
  end
end
