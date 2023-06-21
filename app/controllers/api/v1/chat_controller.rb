class Api::V1::ChatController < ApplicationController

    def index
        chat=Chat.all
        render json: chat, status: :ok
    end
end
