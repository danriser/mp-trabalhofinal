# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Groups', type: :request do
  describe 'GET /index' do
    before do
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
      create(:preference, id: 2, tipo: 'b', descricao: 'b')
      create(:group, id: 1, nome: 'a', tipo: 'a', descricao: 'a', preference_id: 1)
      create(:group, id: 2, nome: 'b', tipo: 'b', descricao: 'b', preference_id: 2)
    end

    context 'index return' do
      it 'should return http status ok' do
        get '/api/v1/group/index'
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /show' do
    before do
      create(:preference, id: 3, tipo: 'c', descricao: 'c')
      create(:group, id: 3, nome: 'c', tipo: 'c', descricao: 'c', preference_id: 3)
    end

    context 'group exists' do
      it 'should return http status ok' do
        get '/api/v1/group/show/3'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'group does not exist' do
      it 'should return http status not_found' do
        get '/api/v1/group/show/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /delete' do
    before do
      create(:preference, id: 3, tipo: 'c', descricao: 'c')
      create(:group, id: 3, nome: 'c', tipo: 'c', descricao: 'c', preference_id: 3)
    end

    context 'group exists' do
      it 'should return http status ok' do
        delete '/api/v1/group/delete/3'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'group does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/group/delete/-1'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST /create' do
    before do
      create(:preference, id: 3, tipo: 'c', descricao: 'c')
      create(:preference, id: 4, tipo: 'd', descricao: 'd')
    end

    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c', preference_id: 3 } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/group/create', params: { group: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'preference_id is invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c', preference_id: -1 } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'name is repeated' do
      it 'should return http status bad_request' do
        post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c', preference_id: 3 } }
        post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c', preference_id: 4 } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /update' do
    before do
      create(:preference, id: 1, tipo: 't1', descricao: 'a')
      create(:preference, id: 2, tipo: 't2', descricao: 'b')
      create(:preference, id: 3, tipo: 't3', descricao: 'c')
      create(:group, id: 1, nome: 'g1', tipo: 'a', descricao: 'a', preference_id: 1)
      create(:group, id: 2, nome: 'g2', tipo: 'b', descricao: 'b', preference_id: 2)
    end

    context 'params are ok' do
      it 'should return http status ok' do
        patch '/api/v1/group/update/1',
              params: { group: { nome: 'test', tipo: 'test', descricao: 'test', preference_id: 3 } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/1', params: { group: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'group does not exist' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/-1',
              params: { group: { nome: 'test2', tipo: 'test2', descricao: 'tes2', preference_id: 3 } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'group name already taken' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/1', params: { group: { nome: 'g2', tipo: 'g2', descricao: 'g2', preference_id: 3 } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'preference_id already taken' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/1', params: { group: { nome: 'g3', tipo: 'g3', descricao: 'g3', preference_id: 2 } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
