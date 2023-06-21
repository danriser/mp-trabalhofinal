require 'rails_helper'

RSpec.describe "Api::V1::ListGroups", type: :request do

  describe "GET /index" do
  
    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:list_group_user,id:1,user_id:1,group_id:1)
    end

    context "index return" do

      before do
        get "/api/v1/list_groups/index"
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end

      it "should return a json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "should return the created instances" do
        expect(JSON.parse(response.body)).to eq([{
          "id" => 1,
          "user_id" => 1,
          "group_id" => 1,
          "created_at" => eval(ListGroupUser.find(1).created_at.to_json),
          "updated_at" => eval(ListGroupUser.find(1).updated_at.to_json),
        }])
      end

    end

  end

  describe "GET /user_groups" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:preference,id:2,tipo:"b",descricao:"b")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:group,id:2,nome:"b",tipo:"b",descricao:"b",preference_id:2)
      create(:list_group_user,id:1,user_id:1,group_id:1)
      create(:list_group_user,id:2,user_id:1,group_id:2)
    end

    context "records exist" do
      it "should return http status ok" do
        get "/api/v1/list_groups/user_groups/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "records do not exist" do
      it "should return http status not_found" do
        get "/api/v1/list_groups/user_groups/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end




end
