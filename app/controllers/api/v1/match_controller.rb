class Api::V1::MatchController < ApplicationController

    def index
        match=Match.all
        render json: match, status: :ok
    end

end
