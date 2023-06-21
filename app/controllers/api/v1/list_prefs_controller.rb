class Api::V1::ListPrefsController < ApplicationController

    def index
        list_pref=ListPreference.all
        render json: list_pref, status: :ok
    end

    def show
        list_pref=ListPreference.find(params[:user_id])
        render json: list_pref, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

end
