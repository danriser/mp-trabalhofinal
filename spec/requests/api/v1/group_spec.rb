# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Groups', type: :request do
  describe 'GET /index' do
    before do
      create(:preference, tipo: 'a', descricao: 'a')
      create(:preference, tipo: 'b', descricao: 'b')
      #create(:group, id: 1, nome: 'a', tipo: 'a', descricao: 'a', preference_id: 1)
      #create(:group, id: 2, nome: 'b', tipo: 'b', descricao: 'b', preference_id: 2)
    end

    context 'index return' do
      it 'should return http status ok' do
        get '/api/v1/group/index'
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /show' do
    group = ''
    before do
      pref = create(:preference, tipo: 'c', descricao: 'c').attributes
      group = Group.find_by(preference_id: pref['id'])
    end

    context 'group exists' do
      it 'should return http status ok' do
        get '/api/v1/group/show/' + group['id'].to_s
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
    group = ''
    before do
      pref1 = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref1['id']).attributes
    end

    context 'group exists' do
      it 'should return http status ok' do
        delete '/api/v1/group/delete/' + group['id'].to_s
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

  # Como agora os grupos estão sendo criados juntos quando uma preferencia é criada, não dá mais para fazer o teste de criação de grupo isoladamente
  describe 'POST /create' do
    #pref1 = ''
    #pref2 = ''
    before do
      #pref1 = create(:preference, tipo: 'c', descricao: 'c').attributes
      #pref2 = create(:preference, tipo: 'd', descricao: 'd').attributes
    end

    #context 'params are ok' do
    #  it 'should return http status created' do
    #    post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c' } }
    #    expect(response).to have_http_status(:created)
    #  end
    #end

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
        post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c' } }
        post '/api/v1/group/create', params: { group: { nome: 'c', tipo: 'c', descricao: 'c' } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /update' do
    pref1 = ''
    pref2 = ''
    group1 = ''
    group2 = ''
    before do
      pref1 = create(:preference, tipo: 'a', descricao: 'a').attributes
      pref2 = create(:preference, tipo: 'b', descricao: 'b').attributes
      group1 = Group.find_by(preference_id: pref1['id']).attributes
      group2 = Group.find_by(preference_id: pref2['id']).attributes
    end

    context 'params are ok' do
      it 'should return http status ok' do
        patch '/api/v1/group/update/' + group1['id'].to_s,
              params: { group: { nome: 'test', tipo: 'test', descricao: 'test' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/' + group1['id'].to_s, params: { group: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'group does not exist' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/-1',
              params: { group: { nome: 'test2', tipo: 'test2', descricao: 'tes2' } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'group name already taken' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/' + group1['id'].to_s, params: { group: { nome: 'b', tipo: 'g2', descricao: 'g2' } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'preference_id already taken' do
      it 'should return http status bad_request' do
        patch '/api/v1/group/update/' + group1['id'].to_s, params: { group: { nome: 'a', tipo: 'g3', descricao: 'g3', preference_id: group2['id'] } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end