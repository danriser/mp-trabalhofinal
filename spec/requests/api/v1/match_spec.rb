require 'rails_helper'

RSpec.describe "Api::V1::Matches", type: :request do

  describe "GET /index" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:match,user_id:1,user_id2:2,match_grade:3)
    end

    context "index return" do

      before do
        get "/api/v1/match/index"
      end

      context "index return" do
        it "should return http status ok" do
          expect(response).to have_http_status(:ok)
        end
      end

    end



  end

end
