# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Chats', type: :request do
  describe 'GET /index' do
    before do
      user1 = create(:user, nome: 'a', password: 'aboasbd', email: 'ola@gmail').attributes
      user2 = create(:user, nome: 'b', password: 'bbosdasd', email: 'ola2@gmail').attributes
      match = create(:match, user_id: user1['id'], user_id2: user2['id'], match_grade: '3').attributes
      chat = create(:chat, id_match: match['id'], id_group: nil).attributes
    end

    context 'index return' do
      before do
        get '/api/v1/chat/index'
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
    chat = ''
    before do
      user1 = create(:user, nome: 'a', password: 'aboasbd', email: 'ola@gmail').attributes
      user2 = create(:user, nome: 'b', password: 'bbosdasd', email: 'ola2@gmail').attributes
      match = create(:match, user_id: user1['id'], user_id2: user2['id'], match_grade: '3').attributes
      chat = create(:chat, id_match: match['id'], id_group: nil).attributes
    end

    context 'record exists' do
      it 'should return http status ok' do
        get '/api/v1/chat/show/' + chat['id'].to_s
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record does not exist' do
      it 'should return http status not_found' do
        get '/api/v1/chat/show/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /delete' do
    chat = ''
    before do
      user1 = create(:user, nome: 'a', password: 'aboasbd', email: 'ola@gmail').attributes
      user2 = create(:user, nome: 'b', password: 'bbosdasd', email: 'ola2@gmail').attributes
      match = create(:match, user_id: user1['id'], user_id2: user2['id'], match_grade: '3').attributes
      chat = create(:chat, id_match: match['id'], id_group: nil).attributes
    end

    context 'record exists' do
      it 'should return http status ok' do
        delete '/api/v1/chat/delete/' + chat['id'].to_s
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/chat/delete/-1'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST /create' do
    match = ''
    group = ''
    before do
      user1 = create(:user, nome: 'a', password: 'aboasbd', email: 'ola@gmail').attributes
      user2 = create(:user, nome: 'b', password: 'bbosdasd', email: 'ola2@gmail').attributes
      match = create(:match, user_id: user1['id'], user_id2: user2['id'], match_grade: '3').attributes
      chat = create(:chat, id_match: match['id'], id_group: nil).attributes
      pref = create(:preference, id: 1, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
    end

    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/chat/create', params: { chat: { id_match: match['id'], id_group: nil } }
        expect(response).to have_http_status(:created)
        post '/api/v1/chat/create', params: { chat: { id_match: nil, id_group: group['id'] } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/chat/create', params: { chat: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
