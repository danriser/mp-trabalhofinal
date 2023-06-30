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

  describe "GET /group_users" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:user,id:2,nome:"b",senha:"b")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:list_group_user,id:1,user_id:1,group_id:1)
      create(:list_group_user,id:2,user_id:2,group_id:1)
    end

    context "records exist" do
      it "should return http status ok" do
        get "/api/v1/list_groups/group_users/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "records do not exist" do
      it "should return http status not_found" do
        get "/api/v1/list_groups/group_users/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "POST /create" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
    end

    context "params are ok" do
      it "should return http status created" do
        post "/api/v1/list_groups/create", params: {list_group_user:{user_id:1,group_id:1}}
        expect(response).to have_http_status(:created)
      end
    end

    context "params are invalid" do
      it "should return http status bad_request" do
        post "/api/v1/list_groups/create", params: {list_group_user:nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "group does not exist" do
      it "should return http status bad_request" do
        post "/api/v1/list_groups/create", params: {list_group_user:{user_id:1,group_id:3}}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "user does not exist" do
      it "should return http status bad_request" do
        post "/api/v1/list_groups/create", params: {list_group_user:{user_id:50,group_id:1}}
        expect(response).to have_http_status(:bad_request)
      end
    end

  end

  describe "DELETE /delete" do

    before do
      create(:user,id:1,nome:"a",senha:"a")
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:list_group_user,id:1,user_id:1,group_id:1)
    end

    context "record exists" do
      it "should return http status ok" do
        delete "/api/v1/list_groups/delete/1"
        expect(response).to have_http_status(:ok)
      end
    end

    context "record does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/list_groups/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end
  
  end




end
