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

      it "return http status ok" do
        expect(response).to have_http_status(:ok)
      end
      it "return json" do
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


end
