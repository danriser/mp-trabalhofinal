# Enzo
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

    def create
        group=Group.new(group_params)
        group.save!
        render json: group, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def update
        group=Group.find(params[:id])
        group.update!(group_params)
        render json: group, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    private
        def group_params
            params.require(:group).permit(:nome,:tipo,:descricao,:preference_id)
        end

end
