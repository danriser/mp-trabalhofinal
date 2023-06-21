class Api::V1::ListGroupsController < ApplicationController

    def index
        list_group=ListGroupUser.all
        render json: list_group, status: :ok
    end

    def user_groups
        list_group=ListGroupUser.find(params[:user_id])
        render json: list_group, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def group_users
        list_group=ListGroupUser.find(params[:group_id])
        render json: list_group, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def create 
        list_group=ListGroupUser.new(list_group_params)
        list_group.save!
        render json: list_group, status: :created
    rescue StandardError => e
        render json:e, status: :bad_request
    end



    private
        def list_group_params
            params.require(:list_group_user).permit(:user_id,:group_id)
        end

end
