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

      # Encontra usuário disponível para fazer o match
      #
      # HU014 - Eu como usuário quero encontrar outros usuários similares via um algoritmo  de match
      #
      # @param [int] o id do usuário querendo fazendo o match
      # @param [JSON] um objeto json conténdo o match grade do match e o id do usuário disponível
      # @raise [StantdardError] Caso os usuários não sejam encontrados
      def faz_match
        user_2_id = 1

        user1 = User.find_by(id: params[:user_id])
        if user1.nil?
          raise ActiveRecord::RecordNotFound, "User not found"
        end
        match_grade = 0.0

        while match_grade < 0.5
          user2 = User.find_by(id: user_2_id)
          if user2.nil?
            raise ActiveRecord::RecordNotFound, "No possible match found"
          end

          if user_2_id == params[:user_id]
            user_2_id += 1
            next
          end

          match_grade = acha_match_grade(params[:user_id], user_2_id)
          user_2_id += 1
        end

        result = {
          match_grade: match_grade,
          user_2: user_2_id
        }
        render json: result, status: :ok
        rescue StandardError => e
          render json: e, status: :bad_request
        rescue ActiveRecord::RecordNotFound => e
          render json: e, status: :not_found
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

      def acha_match_grade(user_1, user_2)
        #user_1 = User.find(user_1)
        #user_2 = User.find(user_2)

        pref1 = ListPreference.where(user_id: user_1)
        pref2 = ListPreference.where(user_id: user_2)

        count_same = 0.0
        count_total = 0.0
        pref1.each do |obj1|
          matching_obj = pref2.find { |obj2| obj2.preference_id == obj1.preference_id }
          count_total += 1
          count_same += 1 if matching_obj
        end

        pref2.each do |obj2|
          matching_obj = pref1.find { |obj1| obj1.preference_id == obj2.preference_id }
          count_total += 1
          count_same += 1 if matching_obj
        end

        match_grade = count_same/count_total
        match_grade
      end


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
