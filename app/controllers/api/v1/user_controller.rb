class Api::V1::UserController < ApplicationController
    def index 
        user=User.all
        render json: user, status: :ok
    end

    def show
        user=User.find(params[:id])
        render json: user, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def create
        user=User.new(user_params)
        user.save!
        render json: user, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end



    private
        def user_params
            params.require(:user).permit(:nome,:senha)
        end

end
