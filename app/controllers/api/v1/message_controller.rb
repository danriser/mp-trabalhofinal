# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a mensagens.
module Api
  module V1
    class MessageController < ApplicationController
      # acts_as_token_authentication_handler_for User, only: []

      # before_action :admin_authentication, only: []

      # Obtem todas as mensagens.
      #
      # @return [JSON] Lista de mensagens em formato JSON.
      def index
        message = Message.all
        render json: array_serializer(message), status: :ok
      end

      # Obtem as mensagens de um usuario especifico pelo ID.
      #
      # @param user_id [Int] O ID do usuário.
      # @return [JSON] As mensagens do usuario em formato JSON.
      # @raise [StandardError] Caso as mensagens do usuario nao sejam encontradas.
      def user_msgs
        message = Message.where('user_id = ?', params[:user_id])
        return_http = :ok
        return_http = :not_found if message.empty?
        render json: array_serializer(message), status: return_http
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Obtem a mensagem pelo seu id
      #
      # HU018 - Eu como usuário quero ver mensagens
      #
      # @param [Int] O ID da mensagem.
      # @return [JSON] a mensagem em formato JSON.
      # @raise [StandardError] Caso a mensagem nao seja encontrada.
      def show
        message = Message.find(params[:id])
        render json: serializer(message), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Deleta uma mensagem pelo seu id
      #
      # HU017 - Eu como usuário quero deletar as minhas mensagens
      #
      # @param [Int] O ID da mensagem.
      # @raise [StandardError] Caso a mensagem nao seja encontrada.
      def delete
        message = Message.find(params[:id])
        message.destroy!
        render json: message, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Deleta todas as mensagens de um usuário
      #
      # HU017 - Eu como usuário quero deletar as minhas mensagens
      #
      # @param [Int] O ID da mensagem.
      def user_msgs_delete
        message = Message.find(params[:user_id])
        Message.where('user_id = ?', message.user_id).destroy_all
        render json: message, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Obtém todas as mensagens de um chat
      #
      # HU018 - Eu como usuário quero ver mensagens
      #
      # @param [Int] o id do chat
      # @return [JSON] uma lista de mensagens
      def chat_msgs
        message = Message.where('chat_id = ?', params[:chat_id])
        render json: array_serializer(message), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Cria uma nova mensagem
      #
      # HU016 - Eu como usuário quero enviar mensagens
      #
      # @param [String] texto da mensagem
      # @param [String] hora de envio
      # @param [Int] id do usuário quer enviou a mensagem
      # @param [Int] id do chat no qual a mensagem foi enviada
      def create
        message = Message.new(msg_params)
        message.save!
        render json: message, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(message)
        Panko::ArraySerializer.new(message, each_serializer: MessageSerializer).to_json
      end

      def serializer(message)
        MessageSerializer.new.serialize_to_json(message)
      end

      def msg_params
        params.require(:message).permit(:chat_id, :user_id, :hora_de_envio, :conteudo)
      end
    end
  end
end
