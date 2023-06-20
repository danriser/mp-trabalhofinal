require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do  

  describe "GET /index" do

    before do
      create(:user,id:1,nome:"tal",senha:"x")
      create(:user,id:2,nome:"ola",senha:"mundo")
    end

    context "index return" do

      before do
        get "/api/v1/user/index"
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
      it "should return json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
      it "should return created instances" do
        expect(JSON.parse(response.body)).to eq([{
          "created_at" => eval(User.find(1).created_at.to_json),
          "id" => 1,
          "nome" => "tal",
          "senha" => "x",
          "updated_at" => eval(User.find(1).updated_at.to_json)
        },
        {
          "created_at" => eval(User.find(2).created_at.to_json),
          "id" => 2,
          "nome" => "ola",
          "senha" => "mundo",
          "updated_at" => eval(User.find(2).updated_at.to_json)
        }])
      end
    end
    
  end

  describe "GET /show" do

    before do
      create(:user,id:2,nome:"ola",senha:"mundo")
    end

    context "user exists" do
      it "should return http status ok" do
        get "/api/v1/user/show/2"
        expect(response).to have_http_status(:ok)
      end
    end

    context "user not found" do
      it "should return http status not found" do
        get "/api/v1/user/show/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "POST /create" do

    let (:user_params) do
      attributes_for(:user)
    end

    context "params are ok" do
      it "should return http status created" do
        post "/api/v1/user/create", params: {user: user_params}
        expect(response).to have_http_status(:created)
      end
    end

    context "params are invalid" do
      it "should return http status bad_request" do
        post "/api/v1/user/create", params: {user: nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "repeated name" do
      it "should return http status bad_request" do
        post "/api/v1/user/create", params: {user: user_params}
        post "/api/v1/user/create", params: {user: user_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "DELETE /delete" do

    let(:user) {create(:user)}

    context "user exists" do
      it "should return http status ok" do
        delete "/api/v1/user/delete/#{user.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "user does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/user/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "PATCH /update" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
    end

    context "params are ok" do
      it "should return http status ok" do
        patch "/api/v1/user/update/1", params: {user: {nome:"c",senha:"c"}}
        expect(response).to have_http_status(:ok)
      end
    end

    context "params are invalid" do
      it "should return http status ok" do
        patch "/api/v1/user/update/1", params: {user:nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "name already taken" do
      it "should return http status bad_request" do
        patch "/api/v1/user/update/1", params: {user:{nome:"b",senha:"b"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "user does not exist" do
      it "should return http status bad_request" do
        patch "/api/v1/user/update/-1", params: {user:{nome:"d",senha:"d"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

end
