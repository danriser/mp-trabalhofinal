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


end
