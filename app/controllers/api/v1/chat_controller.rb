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

    def delete
        chat=Chat.find(params[:id])
        chat.destroy!
        render json: chat, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def create 
        chat=Chat.new(chat_params)
        chat.save!
        render json: chat, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end


    private
        def chat_params
            params.require(:chat).permit(:id_match,:id_group)
        end


end
