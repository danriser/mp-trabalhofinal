class Api::V1::ListPrefsController < ApplicationController

    def index
        list_pref=ListPreference.all
        render json: list_pref, status: :ok
    end

end
