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

    context "returned content" do
      it "should return the specified record" do
        get "/api/v1/message/show/1"
        expect(JSON.parse(response.body)).to eq({
          "id" => 1,
          "chat_id" => 1,
          "user_id" => 1,
          "hora_de_envio" => nil,
          "conteudo" => "ola",
          "created_at" => eval(Message.find(1).created_at.to_json),
          "updated_at" => eval(Message.find(1).updated_at.to_json)
        })
      end
    end

  end


end
