# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Messages', type: :request do
  let(:admin) { create(:user, nome: 'admin_testes2', password: '123456', email: 'admintestes2@teste.com', is_admin: true) }
  describe 'GET /index' do
    before do
      user = create(:user, nome: 'afdsafdsa', password: 'aopqkeoqw', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_match: nil, id_group: group['id']).attributes
      create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'ola')
    end

    context 'index return' do
      before do
        get '/api/v1/message/index', headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
      end

      it 'should return http status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return a json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET /user_msgs' do
    user = ''
    before do
      user = create(:user, nome: 'a', password: 'aihasdas', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_match: nil, id_group: group['id']).attributes
      message = create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'ola').attributes
      create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'teste')
    end

    context 'records exist' do
      it 'should return http status ok' do
        get '/api/v1/message/user_msgs/' + user['id'].to_s, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record dont exist' do
      it 'should return http status not_found' do
        get '/api/v1/message/user_msgs/-1', headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /show' do
    message = ''
    before do
      user = create(:user, nome: 'a', password: 'aihasdas', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_match: nil, id_group: group['id']).attributes
      message = create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'ola').attributes
      create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'teste')
    end

    context 'record exists' do
      it 'should return http status ok' do
        get '/api/v1/message/show/' + message['id'].to_s, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record does not exist' do
      it 'should return http status not_found' do
        get '/api/v1/message/show/-1', headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /delete' do
    message = ''
    before do
      user = create(:user, nome: 'a', password: 'aihasdas', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_match: nil, id_group: group['id']).attributes
      message = create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'ola').attributes
      create(:message, chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'teste')
    end

    context 'record exists' do
      it 'should return http status ok' do
        delete '/api/v1/message/delete/' + message['id'].to_s, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/message/delete/-1', headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /user_msgs_delete' do
    message = ''
    before do
      user1 = create(:user, nome: 'a', password: 'aihasdas', email: 'ola@gmail').attributes
      user2 = create(:user, id: 2, nome: 'b', password: 'boapdoks', email: 'ola2@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_match: nil, id_group: group['id']).attributes
      message = create(:message, chat_id: chat['id'], user_id: user1['id'], hora_de_envio: nil, conteudo: 'ola').attributes
      create(:message, chat_id: chat['id'], user_id: user1['id'], hora_de_envio: nil, conteudo: 'teste')
      create(:message, chat_id: chat['id'], user_id: user2['id'], hora_de_envio: nil, conteudo: 'teste')
    end

    context 'records exist' do
      it 'should return http status ok' do
        delete '/api/v1/message/user_msgs_delete/' + message['id'].to_s, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'user_id does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/message/user_msgs_delete/-1', headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST /create' do
    user = ''
    chat = ''
    before do
      user = create(:user, nome: 'a', password: 'aihasdas', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_match: nil, id_group: group['id']).attributes
    end

    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/message/create',
             params: { message: { chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: 'ola' } }, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:created)
      end
    end

    context 'conteudo is invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/message/create',
             params: { message: { chat_id: chat['id'], user_id: user['id'], hora_de_envio: nil, conteudo: nil } }, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'chat_id is invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/message/create',
             params: { message: { chat_id: 2000, user_id: user['id'], hora_de_envio: nil, conteudo: 'ola' } }, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'user_id is invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/message/create',
             params: { message: { chat_id: chat['id'], user_id: 2000, hora_de_envio: nil, conteudo: 'ola' } }, headers: {'X-User-Email' => admin['email'], 'X-User-Token' => admin['authentication_token'] }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
