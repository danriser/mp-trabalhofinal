# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a {list_group_user}.
module Api
  module V1
    class ListGroupsController < ApplicationController

      #acts_as_token_authentication_handler_for User, only: []

      # Obtém todos os list_group_user.
      #
      # @return [JSON] Lista dos list_group_user em formato JSON.
      def index
        list_group = ListGroupUser.all
        render json: array_serializer(list_group), status: :ok
      end

      # Obtém os grupos no qual um usuário está
      #
      # HU011 - Eu como usuário quero saber em quais grupos eu estou
      #
      # @param [Int] o id do usuário
      # @return [JSON] lista dos grupos no qual um usuário está
      def user_groups
        list_group = ListGroupUser.where('user_id = ?', params[:user_id])
        return_http = :ok
        return_http = :not_found if list_group.empty?
        render json: array_serializer(list_group), status: return_http
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Obtém os usuários que estão em um determinado grupo
      #
      # HU012 - Eu como usuário quero saber quem está em determinado grupo
      #
      # @param [Int] o id do grupo
      # @return [JSON] lista dos usuários no grupo
      def group_users
        list_group = ListGroupUser.where('group_id = ?', params[:group_id])
        return_http = :ok
        return_http = :not_found if list_group.empty?
        render json: array_serializer(list_group), status: return_http
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Cria um novo list_group_user
      #
      # @return [JSON] um json com o list_group_user
      def create
        list_group = ListGroupUser.new(list_group_params)
        list_group.save!
        render json: list_group, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Deleta um list_group_user
      #
      # @param [Int] o id do list_group_user a ser deletado
      def delete
        list_group = ListGroupUser.find(params[:id])
        list_group.destroy!
        render json: list_group, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(group)
        Panko::ArraySerializer.new(group, each_serializer: ListGroupsSerializer).to_json
      end

      def serializer(group)
        ListGroupsSerializer.new.serialize_to_json(group)
      end

      def list_group_params
        params.require(:list_group_user).permit(:user_id, :group_id)
      end
    end
  end
end
