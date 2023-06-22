class Api::V1::MessageController < ApplicationController

    def index
        message=Message.all
        render json: message, status: :ok
    end

    def user_msgs
        message=Message.find(params[:user_id])
        render json: message, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def show
        message=Message.find(params[:id])
        render json: message, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

end
