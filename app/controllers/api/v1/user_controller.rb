class Api::V1::UserController < ApplicationController
    def index 
        user=User.all
        render json: user, status: :ok
    end
end
