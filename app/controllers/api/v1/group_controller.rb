# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a {list_group_user}.
module Api
  module V1
    class GroupController < ApplicationController

      #acts_as_token_authentication_handler_for User
      #before_action :admin_authentication, except: [:index, :show]

      # Obtém todos os grupos.
      #
      # @return [JSON] Lista de grupos em formato JSON.
      def index
        group = Group.all
        render json: array_serializer(group), status: :ok
      end

      # Obtem um grupo especifico pelo seu id.
      #
      # @param user_id [Int] O ID do grupo.
      # @return [JSON] O usuário em formato JSON.
      # @raise [StandardError] Caso o usuário não seja encontrado.
      def show
        group = Group.find(params[:id])
        render json: serializer(group), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

            # Deleta o usuário - requer autenticação
      #
      # HU004 - Eu como usuário quero deletar a minha conta
      #
      # @param id [Int] id do usuário a ser removido
      # @raise [StandardError] Caso o usuário não seja encontardo
      def delete
        group = Group.find(params[:id])
        group.destroy!
        render json: group, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Cria grupo
      #
      # @param nome [String] o nome do grupo
      # @param tipo [String] o tipo do grupo
      # @param descricao [String] a descricao do grupo
      # @param [Int] o ID da preferencia associada ao grupo
      def create
        group = Group.new(group_params)
        group.save!
        render json: group, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Atualiza os dados do grupo
      #
      # @param [JSON] um objeto json com os novos dados do grupo incluindo o seu id que não pode ser alterado
      # @raise [StantdardError] Caso o grupo não seja encontrado
      def update
        group = Group.find(params[:id])
        group.update!(group_params)
        render json: group, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(groups)
        Panko::ArraySerializer.new(groups, each_serializer: GroupSerializer).to_json
      end

      def serializer(group)
        GroupSerializer.new.serialize_to_json(group)
      end

      def group_params
        params.require(:group).permit(:nome, :tipo, :descricao, :preference_id)
      end
    end
  end
end
