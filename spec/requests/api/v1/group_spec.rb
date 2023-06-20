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

end
