# frozen_string_literal: true

# Enzo
module Api
  module V1
    class UserController < ApplicationController

      acts_as_token_authentication_handler_for User, only: [:update, :delete]
      def index
        user = User.all
        render json: array_serializer(user), status: :ok
      end
      def index_match
        user = User.all.select
        filtro =  

      def show
        user = User.find(params[:id])
        render json: serializer(user), status: :ok
      rescue StandardError => e
        render json: e, status: :not_found
      end

      def login
        user = User.find_by(nome: params[:nome])
        if user.valid_password?(params[:password])
            render json: user, status: :ok
        else
            head :unauthorized
        end
      rescue StandardError
          head :unauthorized
      end

      def create
        user = User.new(user_params)
        user.save!
        render json: user, status: :created
      rescue StandardError => e
        render json: e, status: :bad_request
      end
      

      def delete
        user = User.find(params[:id])
        user.destroy!
        render json: user, status: :ok
      rescue StandardError => e
        render json: e, status: :bad_request
      end

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
