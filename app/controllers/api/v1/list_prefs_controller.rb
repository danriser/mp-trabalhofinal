# Humberto
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

    def create
        list_pref=ListPreference.new(list_pref_params)
        list_pref.save!
        render json: list_pref, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def delete
        list_pref=ListPreference.find(params[:id])
        list_pref.destroy!
        render json: list_pref, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    def delete_user_prefs
        list_pref=ListPreference.find(params[:user_id])
        list_pref.destroy!
        render json: list_pref, status: :ok
    rescue StandardError => e
        render json: e,status: :bad_request
    end

    private
        def list_pref_params
            params.require(:list_preference).permit(:user_id,:preference_id)
        end

end
