# Enzo
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

    def create
        match=Match.new(match_params)
        match.save!
        render json: match, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def delete
        match=Match.find(params[:id])
        match.destroy!
        render json: match, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def update
        match=Match.find(params[:id])
        match.update!(match_params)
        render json: match, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    private
        def match_params
            params.require(:match).permit(:user_id,:user_id2,:match_grade)
        end
            
end
