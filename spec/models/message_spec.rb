# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'testing factory' do
    it do
      pref = create(:preference, tipo: 'teste123', descricao: 'teste').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_group: group['id'], id_match: nil).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:message, chat_id: chat['id'], user_id: user['id'], conteudo: 'a')).to be_valid
    end
  end

  context 'validating chat presence' do
    it 'should be invalid if chat_id=nil' do
      pref = create(:preference, tipo: 'teste123', descricao: 'teste').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_group: group['id'], id_match: nil).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:message, chat_id: nil, user_id: user['id'], conteudo: 'a')).to be_invalid
    end
  end

  context 'validating chat existence' do
    it 'should be invalid if chat_id not registered' do
      pref = create(:preference, tipo: 'teste123', descricao: 'teste').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_group: group['id'], id_match: nil).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:message, id: 1, chat_id: -1, user_id: user['id'], conteudo: 'a')).to be_invalid
    end
  end

  context 'validating user presence' do
    it 'should be invalid if user_id=nil' do
      pref = create(:preference, tipo: 'teste123', descricao: 'teste').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_group: group['id'], id_match: nil).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:message, chat_id: chat['id'], user_id: nil, conteudo: 'a')).to be_invalid
    end
  end

  context 'validating user existence' do
    it 'should be invalid if user_id not registered' do
      pref = create(:preference, tipo: 'teste123', descricao: 'teste').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_group: group['id'], id_match: nil).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:message, id: 1, chat_id: chat['id'], user_id: -1, conteudo: 'a')).to be_invalid
    end
  end

  context 'validating conteudo presence' do
    it 'should be invalid if conteudo=nil' do
      pref = create(:preference, tipo: 'teste123', descricao: 'teste').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      chat = create(:chat, id_group: group['id'], id_match: nil).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:message, id: 1, chat_id: chat['id'], user_id: user['id'], conteudo: nil)).to be_invalid
    end
  end
end
