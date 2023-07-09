module Api
    module V1
        class AnalyticController < ApplicationController
            #acts_as_token_authentication_handler_for User, only: []
            #before_action :admin_authentication, only: []
            
            def add
                def create
                    puts params[:title]
                    user = User.new(params[:title])

                    user.save!
                    render json: user, status: :created
                  rescue StandardError => e
                    render json: e, status: :bad_request
                  end
            end

            def show
                data = Analytic.find(params[:title])
                puts data
                render json: data, status: :ok
            end


            def create
                
            end
        end
    end
end
