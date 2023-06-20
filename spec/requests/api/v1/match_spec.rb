require 'rails_helper'

RSpec.describe "Api::V1::Matches", type: :request do

  describe "GET /index" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
    end

    context "index return" do

      before do
        get "/api/v1/match/index"
      end

      context "index return" do

        it "should return http status ok" do
          expect(response).to have_http_status(:ok)
        end

        it "should return json" do
          expect(response.content_type).to eq("application/json; charset=utf-8")
        end

        it "should return created instances" do
          expect(JSON.parse(response.body)).to eq([{
            "created_at" => eval(Match.find(1).created_at.to_json),
            "updated_at" => eval(Match.find(1).updated_at.to_json),
            "id" => 1,
            "user_id" => 1,
            "user_id2" => 2,
            "match_grade" => "3"
          }])
        end
      end

    end


  end

end
