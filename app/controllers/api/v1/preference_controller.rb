class Api::V1::PreferenceController < ApplicationController

    def index
        preference=Preference.all
        render json: preference, status: :ok
    end

end
