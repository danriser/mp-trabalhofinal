# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ListGroups', type: :request do
  describe 'GET /index' do
    before do
      user = create(:user, nome: 'a', password: 'abobasud', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      create(:list_group_user, user_id: user['id'], group_id: group['id'])
    end

    context 'index return' do
      before do
        get '/api/v1/list_groups/index'
      end

      it 'should return http status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return a json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'GET /user_groups' do
    user = ''
    before do
      user = create(:user, nome: 'a', password: 'bblasjasa', email: 'ola@gmail').attributes
      pref1 = create(:preference, tipo: 'a', descricao: 'a').attributes
      pref2 = create(:preference, tipo: 'b', descricao: 'b').attributes
      group1 = Group.find_by(preference_id: pref1['id'])
      group2 = Group.find_by(preference_id: pref2['id'])

      list = create(:list_group_user, user_id: user['id'], group_id: group1['id']).attributes
      create(:list_group_user, user_id: user['id'], group_id: group2['id'])
    end

    context 'records exist' do
      it 'should return http status ok' do
        get '/api/v1/list_groups/user_groups/' + user['id'].to_s
        expect(response).to have_http_status(:ok)
      end
    end

    context 'records do not exist' do
      it 'should return http status not_found' do
        get '/api/v1/list_groups/user_groups/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /group_users' do
    group1 = ''
    before do
      user1 = create(:user, nome: 'a', password: 'bblasjasa', email: 'ola@gmail').attributes
      user2 = create(:user, nome: 'b', password: 'baskbdoas', email: 'ola2@gmail').attributes
      pref1 = create(:preference, tipo: 'a', descricao: 'a').attributes
      group1 = Group.find_by(preference_id: pref1['id'])

      list = create(:list_group_user, user_id: user1['id'], group_id: group1['id']).attributes
      create(:list_group_user, user_id: user2['id'], group_id: group1['id'])
    end

    context 'records exist' do
      it 'should return http status ok' do
        get '/api/v1/list_groups/group_users/' + group1['id'].to_s
        expect(response).to have_http_status(:ok)
      end
    end

    context 'records do not exist' do
      it 'should return http status not_found' do
        get '/api/v1/list_groups/group_users/-1'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    user = ''
    group = ''
    before do
      user = create(:user, nome: 'a', password: 'abobasud', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
    end

    context 'params are ok' do
      it 'should return http status created' do
        post '/api/v1/list_groups/create', params: { list_group_user: { user_id: user['id'], group_id: group['id'] } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'params are invalid' do
      it 'should return http status bad_request' do
        post '/api/v1/list_groups/create', params: { list_group_user: nil }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'group does not exist' do
      it 'should return http status bad_request' do
        post '/api/v1/list_groups/create', params: { list_group_user: { user_id: user['id'], group_id: 2000 } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'user does not exist' do
      it 'should return http status bad_request' do
        post '/api/v1/list_groups/create', params: { list_group_user: { user_id: 2000, group_id: group['id'] } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /delete' do
    list = ''
    before do
      user = create(:user, nome: 'a', password: 'abobasud', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'a', descricao: 'a').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      list = create(:list_group_user, user_id: user['id'], group_id: group['id']).attributes
    end

    context 'record exists' do
      it 'should return http status ok' do
        delete '/api/v1/list_groups/delete/' + list['id'].to_s
        expect(response).to have_http_status(:ok)
      end
    end

    context 'record does not exist' do
      it 'should return http status bad_request' do
        delete '/api/v1/list_groups/delete/-1'
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
