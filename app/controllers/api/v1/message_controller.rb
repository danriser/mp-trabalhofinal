# Controller responsavel por lidar com as operacoes relacionadas a mensagens.
class Api::V1::MessageController < ApplicationController
    # Obtem todas as mensagens.
    #
    # @return [JSON] Lista de mensagens em formato JSON.
    def index
      message = Message.all
      render json: message, status: :ok
    end
  
    # Obtem as mensagens de um usuario especifico pelo ID.
    #
    # @param user_id [Int] O ID do usuario.
    # @return [JSON] As mensagens do usuario em formato JSON.
    # @raise [StandardError] Caso as mensagens do usuario nao sejam encontradas.
    def user_msgs
      message = Message.find(params[:user_id])
      render json: message, status: :ok
    rescue StandardError => e
      render json: e, status: :not_found
    end
  end
  