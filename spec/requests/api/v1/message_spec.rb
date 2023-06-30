require 'rails_helper'

RSpec.describe "Api::V1::Messages", type: :request do


  describe "GET /index" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:chat,id:1,id_match:nil,id_group:1)
      create(:message,id:1,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"ola")
    end

    context "index return" do

      before do
        get "/api/v1/message/index"
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end

      it "should return a json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end


    end

  end

  describe "GET /user_msgs" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:chat,id:1,id_match:nil,id_group:1)
      create(:message,id:1,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"ola")
      create(:message,id:2,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"teste")
    end

    context "records exist" do
      it "should return http status ok" do
        get "/api/v1/message/user_msgs/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "record dont exist" do
      it "should return http status not_found" do
        get "/api/v1/message/user_msgs/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "GET /show" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:chat,id:1,id_match:nil,id_group:1)
      create(:message,id:1,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"ola")
      create(:message,id:2,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"teste")
    end

    context "record exists" do
      it "should return http status ok" do
          get "/api/v1/message/show/1"
          expect(response).to have_http_status(:ok)
      end
    end

    context "record does not exist" do
      it "should return http status not_found" do
        get "/api/v1/message/show/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "DELETE /delete" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:chat,id:1,id_match:nil,id_group:1)
      create(:message,id:1,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"ola")
      create(:message,id:2,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"teste")
    end

    context "record exists" do
      it "should return http status ok" do
        delete "/api/v1/message/delete/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "record does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/message/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "DELETE /user_msgs_delete" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:chat,id:1,id_match:nil,id_group:1)
      create(:message,id:1,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"ola")
      create(:message,id:2,chat_id:1,user_id:1,hora_de_envio:nil,conteudo:"teste")
      create(:message,id:3,chat_id:1,user_id:2,hora_de_envio:nil,conteudo:"teste")
    end

    context "records exist" do
      it "should return http status ok" do
        delete "/api/v1/message/user_msgs_delete/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "user_id does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/message/user_msgs_delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "POST /create" do
  
    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:chat,id:1,id_match:nil,id_group:1)
    end

    context "params are ok" do
      it "should return http status created" do
        post "/api/v1/message/create", params: {message: {chat_id:1, user_id:1, hora_de_envio:nil, conteudo:"ola"}}
        expect(response).to have_http_status(:created)
      end
    end

    context "conteudo is invalid" do
      it "should return http status bad_request" do
        post "/api/v1/message/create", params: {message: {chat_id:1, user_id:1, hora_de_envio:nil, conteudo:nil}}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "chat_id is invalid" do
      it "should return http status bad_request" do
        post "/api/v1/message/create", params: {message: {chat_id:200, user_id:1, hora_de_envio:nil, conteudo:"ola"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "user_id is invalid" do
      it "should return http status bad_request" do
        post "/api/v1/message/create", params: {message: {chat_id:1, user_id:200, hora_de_envio:nil, conteudo:"ola"}}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

end
