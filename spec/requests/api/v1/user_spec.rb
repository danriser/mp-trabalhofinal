# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    before do
      create(:user, nome: 'tal', password: 'xouasdn', email: 'ola@gmail')
      create(:user, nome: 'ola', password: 'munoubasdo', email: 'ola2@gmail')
    end

    context 'index return' do
      before do
        get '/api/v1/user/index'
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
    before do
      create(:user, nome: 'ola', password: 'munadsado', email: 'ola@gmail')
    end

    context 'user exists' do
      it 'should return http status ok' do
        get '/api/v1/user/show/2'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'user not found' do
      it 'should return http status not found' do
        get '/api/v1/user/show/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/user/create', params: { user: { nome: 'joe', password: 'hillary', email: 'teste@gmail' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/user/create', params: { user: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'repeated name' do
      it 'should return http status bad_request' do
        post '/api/v1/user/create', params: { user: { nome: 'joe', password: 'hillary', email: 'teste@gmail' } }
        post '/api/v1/user/create',
             params: { user: { nome: 'joe', password: 'hillknasary', email: 'teste2@gmail' } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /delete' do
    user1 = ''
    before do
      user1 = create(:user, nome: 'tal', password: 'xouasdn', email: 'ola@gmail').attributes
    end

    context 'user exists' do
      it 'should return http status ok' do
        delete '/api/v1/user/delete/1', headers: {'X-User-Email' => user1['email'], 'X-User-Token' => user1['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'user does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/user/delete/-1', headers: {'X-User-Email' => user1['email'], 'X-User-Token' => user1['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /update' do
    user1 = ''
    before do
      user1 = create(:user, nome: 'a', password: 'aaipjdas', email: 'ola2@gmail').attributes
    end

    context 'params are ok' do
      it 'should return http status ok' do
        patch '/api/v1/user/update/1', params: { user: { nome: 'c', email: 'ola4@gmail' } }, headers: {'X-User-Email' => user1['email'], 'X-User-Token' => user1['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params are invalid' do
      it 'should return http status ok' do
        patch '/api/v1/user/update/1', params: { user: nil }, headers: {'X-User-Email' => user1['email'], 'X-User-Token' => user1['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'name already taken' do
      it 'should return http status bad_request' do
        patch '/api/v1/user/update/1', params: { user: { nome: 'b', password: 'b' } }, headers: {'X-User-Email' => user1['email'], 'X-User-Token' => user1['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'user does not exist' do
      it 'should return http status bad_request' do
        patch '/api/v1/user/update/-1', params: { user: { nome: 'd', password: 'd' } }, headers: {'X-User-Email' => user1['email'], 'X-User-Token' => user1['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
