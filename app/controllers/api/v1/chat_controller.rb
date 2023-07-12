# frozen_string_literal: true

module Api
  module V1
    class ChatController < ApplicationController

      #acts_as_token_authentication_handler_for User, only: []

      #acts_as_token_authentication_handler_for User

      # Obtem todos os chats.
      #
      # @return [JSON] Lista de chats em formato JSON.
      def index
        chat = Chat.all
        render json: array_serializer(chat), status: :ok
      end

      # Obtem um chat especefico pelo ID.
      #
      # @param id [Int] O ID do chat.
      # @return [JSON] O chat em formato JSON.
      # @raise [StandardError] Caso o chat não seja encontrado.
      def show
        chat = Chat.find(params[:id])
        render json: serializer(chat), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Exclui um chat especifico pelo ID.
      #
      # HU010 - Eu como usuário quero deletar uma conversa
      #
      # @param id [Int] O ID do chat a ser excluído.
      # @return [JSON] O chat excluído em formato JSON.
      # @raise [StandardError] Caso o chat não possa ser excluído.
      def delete
        chat = Chat.find(params[:id])
        chat.destroy!
        render json: chat, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Cria um novo chat.
      #
      # HU009 - Eu como usuário quero iniciar uma conversa com outros usuários
      #
      # @param chat_params [String] Parâmetros do chat a ser criado.
      # @option chat_params [Int] :id_match O ID da correspondência do chat.
      # @option chat_params [Int] :id_group O ID do grupo do chat.
      # @return [JSON] O chat criado em formato JSON.
      # @raise [StandardError] Caso o chat não possa ser criado.
      def create
        chat = Chat.new(chat_params)
        chat.save!
        render json: chat, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(chat)
        Panko::ArraySerializer.new(chat, each_serializer: ChatSerializer).to_json
      end

      def serializer(chat)
        ChatSerializer.new.serialize_to_json(chat)
      end

      # Define os parametros permitidos para a criacao do chat.
      #
      # @return [String] Os parametros permitidos para a criacao do chat.
      def chat_params
        params.require(:chat).permit(:id_match, :id_group)
      end
    end
  end
end
