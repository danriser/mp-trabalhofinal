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

  describe "GET /show" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:user,id:3,nome:"c",senha:"c")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
      create(:match,id:2,user_id:2,user_id2:3,match_grade:"2")
    end

    context "match exists" do
      it "should return http status ok" do
        get "/api/v1/match/show/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "user does not exist" do
      it "should return http status not_found" do
        get "/api/v1/match/show/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "POST /create" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
    end

    context "params are ok" do
      it "should return http status created" do
        post "/api/v1/match/create", params: {match: {user_id:1,user_id2:2,match_grade:"3"}}
        expect(response).to have_http_status(:created)
      end
    end

    context "params are invalid" do
      it "should return http status bad_request" do
        post "/api/v1/match/create", params: {match:nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "user_id is invalid" do
      it "should return http status bad_request" do
        post "/api/v1/match/create", params: {match: {user_id:0,user_id2:2,match_grade:"3"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "DELETE /delete" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:user,id:3,nome:"c",senha:"c")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
      create(:match,id:2,user_id:2,user_id2:3,match_grade:"2")
    end

    context "match exists" do
      it "should return http status ok" do
        delete "/api/v1/match/delete/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "match does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/match/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end


end
