# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'testing factory' do
    it do
      create(:preference, id: 1)
      create(:group, id: 1, preference_id: 1)
      create(:chat, id: 1, id_group: 1, id_match: nil)
      create(:user, id: 1, nome: 'david', senha: 'herbert')
      expect(build(:message, id: 1, chat_id: 1, user_id: 1, conteudo: 'a')).to be_valid
    end
  end

  context 'validating chat presence' do
    it 'should be invalid if chat_id=nil' do
      create(:preference, id: 1)
      create(:group, id: 1, preference_id: 1)
      create(:chat, id: 1, id_group: 1, id_match: nil)
      create(:user, id: 1, nome: 'david', senha: 'herbert')
      expect(build(:message, id: 1, chat_id: nil, user_id: 1, conteudo: 'a')).to be_invalid
    end
  end

  context 'validating chat existence' do
    it 'should be invalid if chat_id not registered' do
      create(:preference, id: 1)
      create(:group, id: 1, preference_id: 1)
      create(:chat, id: 1, id_group: 1, id_match: nil)
      create(:user, id: 1, nome: 'david', senha: 'herbert')
      expect(build(:message, id: 1, chat_id: 2, user_id: 1, conteudo: 'a')).to be_invalid
    end
  end

  context 'validating user presence' do
    it 'should be invalid if user_id=nil' do
      create(:preference, id: 1)
      create(:group, id: 1, preference_id: 1)
      create(:chat, id: 1, id_group: 1, id_match: nil)
      create(:user, id: 1, nome: 'david', senha: 'herbert')
      expect(build(:message, id: 1, chat_id: 1, user_id: nil, conteudo: 'a')).to be_invalid
    end
  end

  context 'validating user existence' do
    it 'should be invalid if user_id not registered' do
      create(:preference, id: 1)
      create(:group, id: 1, preference_id: 1)
      create(:chat, id: 1, id_group: 1, id_match: nil)
      create(:user, id: 1, nome: 'david', senha: 'herbert')
      expect(build(:message, id: 1, chat_id: 1, user_id: 3, conteudo: 'a')).to be_invalid
    end
  end

  context 'validating conteudo presence' do
    it 'should be invalid if conteudo=nil' do
      create(:preference, id: 1)
      create(:group, id: 1, preference_id: 1)
      create(:chat, id: 1, id_group: 1, id_match: nil)
      create(:user, id: 1, nome: 'david', senha: 'herbert')
      expect(build(:message, id: 1, chat_id: 1, user_id: 1, conteudo: nil)).to be_invalid
    end
  end
end
