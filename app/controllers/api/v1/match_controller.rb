# frozen_string_literal: true

# Enzo
module Api
  module V1
    class MatchController < ApplicationController
      #acts_as_token_authentication_handler_for User, only: []
      #before_action :admin_authentication, only: []

      def index
        match = Match.all
        render json: array_serializer(match), status: :ok
      end

      def show
        match = Match.find(params[:id])
        render json: serializer(match), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      def create
        match = Match.new(match_params)
        match.save!
        render json: match, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      def delete
        match = Match.find(params[:id])
        match.destroy!
        render json: match, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

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
