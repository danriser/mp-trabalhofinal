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
      it "return http status ok" do
        expect(response).to have_http_status(:ok)
      end
      it "return json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
      it "return created instances" do
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

end
