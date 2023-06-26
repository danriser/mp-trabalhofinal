# Controller responsavel por lidar com as operacoes relacionadas a listas de preferencias.
class Api::V1::ListPrefsController < ApplicationController
    # Obtem todas as listas de preferencias.
    #
    # @return [JSON] Lista de listas de preferencias em formato JSON.
    def index
      list_pref = ListPreference.all
      render json: list_pref, status: :ok
    end
  
    # Obtem uma lista de preferencias especifica pelo ID do usuario.
    #
    # @param user_id [Int] O ID do usuario.
    # @return [JSON] A lista de preferencias em formato JSON.
    # @raise [StandardError] Caso a lista de preferencias nao seja encontrada.
    def show
      list_pref = ListPreference.find(params[:user_id])
      render json: list_pref, status: :ok
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
      list_pref = ListPreference.new(list_pref_params)
      list_pref.save!
      render json: list_pref, status: :created
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
      list_pref.destroy!
      render json: list_pref, status: :ok
    rescue StandardError => e
      render json: e, status: :bad_request
    end
  
    private
  
    # Define os parametros permitidos para a criacao da lista de preferencias.
    #
    # @return [String] Os parametros permitidos para a criacao da lista de preferencias.
    def list_pref_params
      params.require(:list_preference).permit(:user_id, :preference_id)
    end
  end
  