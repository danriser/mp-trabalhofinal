require 'rails_helper'

RSpec.describe "Api::V1::Groups", type: :request do


  describe "GET /index" do

    before do
      create(:preference,id:1,tipo:"a",descricao:"a")
      create(:preference,id:2,tipo:"b",descricao:"b")
      create(:group,id:1,nome:"a",tipo:"a",descricao:"a",preference_id:1)
      create(:group,id:2,nome:"b",tipo:"b",descricao:"b",preference_id:2)
    end

    context "index return" do
      it "should return http status ok" do
        get "/api/v1/group/index"
        expect(response).to have_http_status(:ok)
      end
    end

  end

  describe "GET /show" do

    before do
      create(:preference,id:3,tipo:"c",descricao:"c")
      create(:group,id:3,nome:"c",tipo:"c",descricao:"c",preference_id:3)
    end

    context "group exists" do
      it "should return http status ok" do
        get "/api/v1/group/show/3"
        expect(response).to have_http_status(:ok)
      end
    end

    context "group does not exist" do
      it "should return http status not_found" do
        get "/api/v1/group/show/-1"
        expect(response).to have_http_status(:not_found)
      end
    end

  end

  describe "DELETE /delete" do

    before do
      create(:preference,id:3,tipo:"c",descricao:"c")
      create(:group,id:3,nome:"c",tipo:"c",descricao:"c",preference_id:3)
    end

    context "group exists" do
      it "should return http status ok" do
        delete "/api/v1/group/delete/3"
        expect(response).to have_http_status(:ok)
      end
    end

    context "group does not exist" do
      it "should return http status bad_request" do
        delete "/api/v1/group/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end

  end


end
