class Api::V1::PreferenceController < ApplicationController

    def index
        preference=Preference.all
        render json: preference, status: :ok
    end

    def show
        preference=Preference.find(params[:id])
        render json: preference, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def create
        preference=Preference.new(preference_params)
        preference.save!
        render json: preference, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def delete
        preference=Preference.find(params[:id])
        preference.destroy!
        render json: preference, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def update
        preference=Preference.find(params[:id])
        preference.update!(preference_params)
        render json: preference, status: :ok
    rescue StandardError => e
        render json:e, status: :bad_request
    end

    private
        def preference_params
            params.require(:preference).permit(:tipo,:descricao)
        end

end
