# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Matches', type: :request do
  describe 'GET /index' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoinasd', email: 'ola@gmail')
      create(:user, id: 2, nome: 'b', password: 'baisdnas', email: 'ola2@gmail')
      create(:match, id: 1, user_id: 1, user_id2: 2, match_grade: '3')
    end

    context 'index return' do
      before do
        get '/api/v1/match/index'
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
      create(:user, id: 1, nome: 'a', password: 'aasodn', email: 'ola2@gmail')
      create(:user, id: 2, nome: 'b', password: 'boiabsd', email: 'ola3@gmail')
      create(:user, id: 3, nome: 'c', password: 'cpiads', email: 'ola@gmail')
      create(:match, id: 1, user_id: 1, user_id2: 2, match_grade: '3')
      create(:match, id: 2, user_id: 2, user_id2: 3, match_grade: '2')
    end

    context 'match exists' do
      it 'should return http status ok' do
        get '/api/v1/match/show/1'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'user does not exist' do
      it 'should return http status not_found' do
        get '/api/v1/match/show/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    before do
      create(:user, id: 1, nome: 'a', password: 'ainadsd', email: 'ola@gmail')
      create(:user, id: 2, nome: 'b', password: 'bpasod', email: 'ola4@gmail')
    end

    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/match/create', params: { match: { user_id: 1, user_id2: 2, match_grade: '3' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/match/create', params: { match: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'user_id is invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/match/create', params: { match: { user_id: 0, user_id2: 2, match_grade: '3' } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST /find' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aolsdabn', email: 'ola@gmail')
      create(:user, id: 2, nome: 'b', password: 'baindas', email: 'ola2@gmail')
      create(:user, id: 3, nome: 'c', password: 'cpiasndp', email: 'ola3@gmail')
      create(:user, id: 4, nome: 'd', password: 'fdsafdas', email: 'ola4@gmail')
      create(:user, id: 90, nome: 'e', password: 'fdsafdas', email: 'ola5@gmail')
      create(:preference, id: 1, tipo: 'a', descricao: 'a')
      create(:preference, id: 2, tipo: 'b', descricao: 'b')
      create(:preference, id: 3, tipo: 'c', descricao: 'c')
      create(:preference, id: 4, tipo: 'd', descricao: 'd')
      create(:preference, id: 5, tipo: 'e', descricao: 'e')
      create(:preference, id: 5050, tipo: 'f', descricao: 'f')
      create(:list_preference, user_id: 1, preference_id: 1)
      create(:list_preference, user_id: 1, preference_id: 2)
      create(:list_preference, user_id: 2, preference_id: 1)
      create(:list_preference, user_id: 2, preference_id: 2)
      create(:list_preference, user_id: 2, preference_id: 3)
      create(:list_preference, user_id: 2, preference_id: 4)
      create(:list_preference, user_id: 3, preference_id: 1)
      create(:list_preference, user_id: 4, preference_id: 5)
      create(:list_preference, user_id: 90, preference_id: 5050)
    end

    context 'params are ok' do
      it 'should find similar user' do
        post '/api/v1/match/find', params: { user_id: 1 }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/match/find', params: { user_id: 0 }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'no possible match' do
      it 'should return http status not_found' do
        post '/api/v1/match/find', params: { user_id: 90 }
        puts response.body
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /delete' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aolsdabn', email: 'ola@gmail')
      create(:user, id: 2, nome: 'b', password: 'baindas', email: 'ola2@gmail')
      create(:user, id: 3, nome: 'c', password: 'cpiasndp', email: 'ola3@gmail')
      create(:match, id: 1, user_id: 1, user_id2: 2, match_grade: '3')
      create(:match, id: 2, user_id: 2, user_id2: 3, match_grade: '2')
    end

    context 'match exists' do
      it 'should return http status ok' do
        delete '/api/v1/match/delete/1'
        expect(response).to have_http_status(:ok)
      end
    end

    context 'match does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/match/delete/-1'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /update' do
    before do
      create(:user, id: 1, nome: 'a', password: 'aoasdou', email: 'ola@gmail')
      create(:user, id: 2, nome: 'b', password: 'bpiijqpi', email: 'ola2@gmail')
      create(:user, id: 3, nome: 'c', password: 'cnapnsd', email: 'ola3@gmail')
      create(:match, id: 1, user_id: 1, user_id2: 2, match_grade: '3')
      create(:match, id: 2, user_id: 2, user_id2: 3, match_grade: '2')
    end

    context 'params are ok' do
      it 'should return http status ok' do
        patch '/api/v1/match/update/1', params: { match: { match_grade: '5' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        patch '/api/v1/match/update/1', params: { match: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'match does not exist' do
      it 'should return http status bad_request' do
        patch '/api/v1/match/update/-1', params: { match: { match_grade: '27' } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
