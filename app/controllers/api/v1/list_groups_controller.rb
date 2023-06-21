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



end
