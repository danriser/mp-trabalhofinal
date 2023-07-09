module Api
    module V1
        class AnalyticController < ApplicationController
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
