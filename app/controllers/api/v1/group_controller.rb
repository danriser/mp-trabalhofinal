class Api::V1::GroupController < ApplicationController

    def index
        group=Group.all
        render json: group, status: :ok
    end

    def show
        group=Group.find(params[:id])
        render json: group, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def delete
        group=Group.find(params[:id])
        group.destroy!
        render json: group, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

end
