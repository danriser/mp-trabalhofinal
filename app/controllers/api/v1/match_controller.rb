class Api::V1::MatchController < ApplicationController

    def index
        match=Match.all
        render json: match, status: :ok
    end

    def show
        match=Match.find(params[:id])
        render json: match, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end
end
