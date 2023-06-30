class Api::V1::ListPrefsController < ApplicationController

    def index
        list_pref=ListPreference.all
        render json: array_serializer(list_pref), status: :ok
    end

    def show
        list_pref=ListPreference.where("user_id = ?",params[:user_id])
        return_http=:ok
        if(list_pref.empty?)
            return_http=:not_found
        end
        render json: array_serializer(list_pref), status: return_http
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
        ListPreference.where(user_id:(list_pref.user_id)).destroy_all
        render json: list_pref, status: :ok
    rescue StandardError => e
        render json: e,status: :bad_request
    end

    private

        def array_serializer(list_pref)
            Panko::ArraySerializer.new(list_pref,each_serializer: ListPrefsSerializer).to_json
        end

        def serializer(list_pref)
            ListPrefsSerializer.new.serialize_to_json(list_pref)
        end

        def list_pref_params
            params.require(:list_preference).permit(:user_id,:preference_id)
        end

end
