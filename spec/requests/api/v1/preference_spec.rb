# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Preferences', type: :request do
  let(:admin) {
    create(:user, nome: 'admin_testes2', password: '123456', email: 'admintestes2@teste.com', is_admin: true)
  }
  describe 'GET /index' do
    before do
      pref1 = create(:preference, tipo: 'a', descricao: 'a').attributes
      pref2 = create(:preference, tipo: 'b', descricao: 'b').attributes
    end

    context 'index return' do
      before do
        get '/api/v1/preference/index',
            headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
      end

      it 'should return http status ok' do
        expect(response).to have_http_status(:ok)
      end
      it 'should return json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET /show' do
    pref1 = ''
    before do
      pref1 = create(:preference, tipo: 'c', descricao: 'c').attributes
    end

    context 'preference exists' do
      it 'should return http status ok' do
        get '/api/v1/preference/show/' + pref1['id'].to_s,
            headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'preference does not exist' do
      it 'should return http status not_found' do
        get '/api/v1/preference/show/-1',
            headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    let(:preference_params) do
      attributes_for(:preference)
    end

    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/preference/create', params: { preference: preference_params },
                                          headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/preference/create', params: { preference: nil },
                                          headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'repeated name' do
      it 'should return http status bad_request' do
        post '/api/v1/preference/create', params: { preference: preference_params },
                                          headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        post '/api/v1/preference/create', params: { preference: preference_params },
                                          headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /delete' do
    pref1 = ''
    before do
      pref1 = create(:preference, tipo: 'c', descricao: 'c').attributes
    end

    context 'preference exists' do
      it 'should return http status ok' do
        delete "/api/v1/preference/delete/" + pref1['id'].to_s,
               headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'preference does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/preference/delete/-1',
               headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /update' do
    pref1 = ''
    before do
      pref1 = create(:preference, tipo: 'c', descricao: 'c')
      pref2 = create(:preference, tipo: 'd', descricao: 'd')
    end

    context 'params are ok' do
      it 'should return http status ok' do
        patch '/api/v1/preference/update/' + pref1['id'].to_s,
              params: { preference: { tipo: 'teste', descricao: 'teste' } }, headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        patch '/api/v1/preference/update/' + pref1['id'].to_s, params: { preference: nil },
                                                               headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'tipo is repeated' do
      it 'should return http status bad_request' do
        patch '/api/v1/preference/update/' + pref1['id'].to_s, params: { preference: { tipo: 'd', descricao: 'd' } },
                                                               headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'preference does not exist' do
      it 'should return http status bad_request' do
        patch '/api/v1/preference/update/-1', params: { preference: { tipo: 'ola', descricao: 'mundo' } },
                                              headers: { 'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
