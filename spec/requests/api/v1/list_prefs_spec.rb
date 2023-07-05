# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ListPrefs', type: :request do
  describe 'GET /index' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoasdni', email: 'ola@gmail')
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
      create(:list_preference, id: 1, user_id: 1, preference_id: 1)
    end

    context 'index return' do
      before do
        get '/api/v1/list_prefs/index'
      end

      it 'should return http status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return a json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET /show' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoasdni', email: 'ola@gmail')
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
      create(:preference, id: 2, tipo: 'b', descricao: 'b')
      create(:list_preference, id: 1, user_id: 1, preference_id: 1)
      create(:list_preference, id: 2, user_id: 1, preference_id: 2)
    end

    context 'records exist' do
      it 'should return http status ok' do
        get '/api/v1/list_prefs/show/1'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'records dont exist' do
      it 'should return http status not_found' do
        get '/api/v1/list_prefs/show/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoasdni', email: 'ola@gmail')
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
    end

    context 'params are valid' do
      it 'should return http status created' do
        post '/api/v1/list_prefs/create', params: { list_preference: { user_id: 1, preference_id: 1 } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/list_prefs/create', params: { list_preference: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'user does not exist' do
      it 'should return http status bad_request' do
        post '/api/v1/list_prefs/create', params: { list_preference: { user_id: 2, preference_id: 1 } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'preference does not exist' do
      it 'should return http status bad_request' do
        post '/api/v1/list_prefs/create', params: { list_preference: { user_id: 1, preference_id: 2 } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /delete' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoasdni', email: 'ola@gmail')
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
      create(:list_preference, id: 1, user_id: 1, preference_id: 1)
    end

    context 'record exists' do
      it 'should return http status ok' do
        delete '/api/v1/list_prefs/delete/1'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/list_prefs/delete/-1'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /delete_user_prefs' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoasdni', email: 'ola@gmail')
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
      create(:preference, id: 2, tipo: 'b', descricao: 'b')
      create(:list_preference, id: 1, user_id: 1, preference_id: 1)
      create(:list_preference, id: 2, user_id: 1, preference_id: 2)
    end

    context 'records exist' do
      it 'should return http status ok' do
        delete '/api/v1/list_prefs/delete_user_prefs/1'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'records does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/list_prefs/delete_user_prefs/-1'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
