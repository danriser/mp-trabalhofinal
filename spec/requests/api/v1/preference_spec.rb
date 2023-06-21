require 'rails_helper'

RSpec.describe "Api::V1::Preferences", type: :request do

  describe "GET /index" do

    before do
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:preference,id:2,tipo:"b",descricao:"b")
    end

    context "index return" do

      before do
        get "/api/v1/preference/index"
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
      it "should return json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
      it "should return created instances"do
        expect(JSON.parse(response.body)).to eq([{
          "created_at" => eval(Preference.find(1).created_at.to_json),
          "id" => 1,
          "tipo" => "a",
          "descricao" => "a",
          "updated_at" => eval(Preference.find(1).updated_at.to_json)
        },
        {
          "created_at" => eval(Preference.find(2).created_at.to_json),
          "id" => 2,
          "tipo" => "b",
          "descricao" => "b",
          "updated_at" => eval(Preference.find(2).updated_at.to_json)
        }])
      end

    end
  
  end

  describe "GET /show" do

    before do
      create(:preference,id:3,tipo:"c",descricao:"c")
    end

    context "preference exists" do
      it "should return http status ok" do
        get "/api/v1/preference/show/3"
        expect(response).to have_http_status(:ok)
      end
    end

    context "preference does not exist" do
      it "should return http status not_found" do
        get "/api/v1/preference/show/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "POST /create" do

    let (:preference_params) do
      attributes_for(:preference)
    end

    context "params are ok" do
      it "should return http status created" do
        post "/api/v1/preference/create", params: {preference: preference_params}
        expect(response).to have_http_status(:created)
      end
    end

    context "params are invalid" do
      it "should return http status bad_request" do
        post "/api/v1/preference/create", params: {preference: nil}
        expect(response).to have_http_status(:bad_request)
      end
    end
    
    context "repeated name" do
      it "should return http status bad_request" do
        post "/api/v1/preference/create", params: {preference: preference_params}
        post "/api/v1/preference/create", params: {preference: preference_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "DELETE /delete" do

    let(:preference) {create(:preference)}

    context "preference exists" do
      it "should return http status ok" do
        delete "/api/v1/preference/delete/#{preference.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "preference does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/preference/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "PATCH /update" do
    
    before do
      create(:preference,id:3,tipo:"c",descricao:"c")
      create(:preference,id:4,tipo:"d",descricao:"d")
    end

    context "params are ok" do
      it "should return http status ok" do
        patch "/api/v1/preference/update/3", params:{preference: {tipo:"teste",descricao:"teste"}}
        expect(response).to have_http_status(:ok)
      end
    end

    context "params are invalid" do
      it "should return http status bad_request" do
        patch "/api/v1/preference/update/3", params:{preference:nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "tipo is repeated" do
      it "should return http status bad_request" do
        patch "/api/v1/preference/update/3", params:{preference: {tipo:"d",descricao:"d"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "preference does not exist" do
      it "should return http status bad_request" do
        patch "/api/v1/preference/update/-1", params:{preference: {tipo:"ola",descricao:"mundo"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

end
