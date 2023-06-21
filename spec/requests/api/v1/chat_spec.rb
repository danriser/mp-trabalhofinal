require 'rails_helper'

RSpec.describe "Api::V1::Chats", type: :request do

  describe "GET /index" do
    
    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
      create(:chat,id:1,id_match:1,id_group:nil)
    end

    context "index return" do

      before do
        get "/api/v1/chat/index"
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end

      it "should return a json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

    end

  end

  describe "GET /show" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
      create(:chat,id:1,id_match:1,id_group:nil)
    end

    context "record exists" do
      it "should return http status ok" do
        get "/api/v1/chat/show/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "record does not exist" do
      it "should return http status not_found" do
        get "/api/v1/chat/show/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  
  end

  describe "DELETE /delete" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
      create(:chat,id:1,id_match:1,id_group:nil)
    end

    context "record exists" do
      it "should return http status ok" do
        delete "/api/v1/chat/delete/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "record does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/chat/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "POST /create" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",preference_id:1,tipo:"a",descricao:"a")
      create(:match,id:1,user_id:1,user_id2:2,match_grade:"3")
    end

    context "params are ok" do
      it "should return http status created" do
        post "/api/v1/chat/create", params: {chat: {id_match:1,id_group:nil}}
        expect(response).to have_http_status(:created)
        post "/api/v1/chat/create", params: {chat: {id_match:nil,id_group:1}}
        expect(response).to have_http_status(:created)
      end
    end

    context "params are invalid" do
      it "should return http status bad_request" do
        post "/api/v1/chat/create", params: {chat:nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end


end
