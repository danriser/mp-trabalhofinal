class Api::V1::ChatController < ApplicationController

    def index
        chat=Chat.all
        render json: chat, status: :ok
    end

    def show
        chat=Chat.find(params[:id])
        render json: chat, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end


end
