class Api::V1::GroupController < ApplicationController

    def index
        group=Group.all
        render json: group, status: :ok
    end

end
