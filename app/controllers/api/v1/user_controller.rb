# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a usuários.
module Api
  module V1
    class UserController < ApplicationController
      acts_as_token_authentication_handler_for User, only: [:update, :delete]
      before_action :admin_authentication, only: []

      # Obtém todos os usuários.
      #
      # @return [JSON] Lista de preferencias em formato JSON.
      def index
        user = User.all
        render json: array_serializer(user), status: :ok
      end
      def index_match
        # user = User.all.select 
      end

      # Obtem um usuário especifico pelo seu id.
      #
      # HU003 - Eu como usuário quero buscar outros usuários
      #
      # @param user_id [Int] O ID do usuario.
      # @return [JSON] O usuário em formato JSON.
      # @raise [StandardError] Caso o usuário não seja encontrado.
      def show
        user = User.find(params[:id])
        render json: serializer(user), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Realiza o login do usuário
      #
      # HU002 - Eu como usuário quero fazer login no sistema
      #
      # @param nome [String] o nome do usuário
      # @param senha [String] a senha do usuário
      # @return [JSON] o usuário com um authentication token 
      # @raise [StandardError] Caso o usuário não seja encontrado ou a senha esteja errada.
      def login
        user = User.find_by(nome: params[:nome])
        if user.valid_password?(params[:password])
            render json: user, status: :ok
        else
            head :unauthorized
        end
      rescue StandardError => e
          render json: e, status: :unauthorized
      end

      # Cria usuário
      #
      # HU001 - Eu como usuário quero registrar minha conta para usar o sistema.
      #
      # @param nome [String] o nome do usuário
      # @param senha [String] a senha do usuário
      # @param email [String] o email do usuário
      # @raise [StandardError] Caso a senha tenha menos de 6 caractéries
      def create
        user = User.new(user_params)
        user.save!
        render json: user, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Deleta o usuário - requer autenticação
      #
      # HU004 - Eu como usuário quero deletar a minha conta
      #
      # @param id [Int] id do usuário a ser removido
      # @raise [StandardError] Caso o usuário não seja encontardo
      def delete
        user = User.find(params[:id])
        user.destroy!
        render json: user, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Atualiza os dados do usuário - requer autenticação
      #
      # HU005 - Eu como usuário quero atualizar os meus dados
      #
      # @param [JSON] um objeto json com os novos dados do usuário incluindo o seu id que não pode ser alterado
      # @raise [StantdardError] Caso o usuário não seja encontrado
      def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: user, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(users)
        Panko::ArraySerializer.new(users, each_serializer: UserSerializer).to_json
      end

      def serializer(user)
        UserSerializer.new.serialize_to_json(user)
      end

      def user_params
        params.require(:user).permit(:nome, :password, :email)
      end
    end
  end
end
