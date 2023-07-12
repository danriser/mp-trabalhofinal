# frozen_string_literal: true

# Controller responsavel por lidar com as operacoes relacionadas a matchs.
module Api
  module V1
    class MatchController < ApplicationController
      #acts_as_token_authentication_handler_for User, only: []
      #before_action :admin_authentication, only: []

      # Obtém todos os matchs.
      # 
      # HA006 - Eu como admin quero ver todos os matchs
      #
      # @return [JSON] Lista de matchs em formato JSON.
      def index
        match = Match.all
        render json: array_serializer(match), status: :ok
      end

      # Obtém um match com base em seu id
      #
      # @param [Int] o id do usuário
      # @return [JSON] o match em formato JSON
      # @raise [StantdardError] Caso o match não seja encontrado
      def show
        match = Match.find(params[:id])
        render json: serializer(match), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      # Cria uma nova match
      #
      # @param [int] o id do usuário fazendo o match
      # @param [int] o id do outro usuário fazendo o match
      # @param [float] o match grade do match
      # @raise [StantdardError] Caso os usuários não sejam encontrados
      def create
        match = Match.new(match_params)
        match.save!
        render json: match, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Deleta o match
      #
      # HU015 - Eu como usuário quero deletar um match
      #
      # @param [int] o id do match a ser deletado
      # @raise [StantdardError] Caso o match não seja encontrado
      def delete
        match = Match.find(params[:id])
        match.destroy!
        render json: match, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      # Atualiza o match
      #
      # @param [JSON] um objeto json com os novos dados do match incluindo o seu id que não pode ser alterado
      # @raise [StantdardError] Caso o match não seja encontrado
      def update
        match = Match.find(params[:id])
        match.update!(match_params)
        render json: match, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      private

      def array_serializer(match)
        Panko::ArraySerializer.new(match, each_serializer: MatchSerializer).to_json
      end

      def serializer(match)
        MatchSerializer.new.serialize_to_json(match)
      end

      def match_params
        params.require(:match).permit(:user_id, :user_id2, :match_grade)
      end
    end
  end
end
