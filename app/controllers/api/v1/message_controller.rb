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
      message=Message.where("user_id = ?",params[:user_id])
      return_http=:ok
      if(message.empty?)
          return_http=:not_found
      end
      render json: message, status: return_http
    rescue StandardError => e
      render json: e, status: :not_found
    end

    def show
      message=Message.find(params[:id])
      render json: message, status: :ok
    rescue StandardError => e
      render json: e, status: :not_found
    end

    def delete
      message=Message.find(params[:id])
      message.destroy!
      render json: message, status: :ok
    rescue StandardError => e
      render json: e, status: :bad_request
    end

    def user_msgs_delete
      message=Message.find(params[:user_id])
      Message.where("user_id = ?",message.user_id).destroy_all
      render json: message, status: :ok
    rescue StandardError => e
      render json: e, status: :bad_request
    end

    def chat_msgs
      message=Message.where("chat_id = ?",params[:chat_id])
      render json: message, status: :ok
    rescue StandardError => e
      render json: e, status: :not_found
    end

end
  