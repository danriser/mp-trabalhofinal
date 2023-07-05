# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListGroupUser, type: :model do
  context 'testing factory' do
    it do
      create(:user, id: 2, nome: 'david', password: 'herbert', email: 'ola@gmail')
      create(:preference, id: 2, tipo: 'filme', descricao: 'filme')
      create(:group, id: 2, preference_id: 2, nome: 'a', tipo: 'a', descricao: 'a')
      expect(build(:list_group_user, user_id: 2, group_id: 2)).to be_valid
    end
  end

  context 'validating user presence' do
    it 'should be invalid if user_id=nil' do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      create(:group, id: 1, preference_id: 1, nome: 'a', tipo: 'a', descricao: 'a')
      expect(build(:list_group_user, user_id: nil, group_id: 1)).to be_invalid
    end
  end

  context 'validating user existence' do
    it 'should be invalid if user_id not registered' do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      create(:group, id: 1, preference_id: 1, nome: 'a', tipo: 'a', descricao: 'a')
      expect(build(:list_group_user, user_id: 1, group_id: 1)).to be_invalid
    end
  end

  context 'validating group presence' do
    it 'should be invalid if group_id=nil' do
      create(:user, id: 1, nome: 'david', password: 'herbert', email: 'ola@gmail')
      expect(build(:list_group_user, user_id: 1, group_id: nil)).to be_invalid
    end
  end

  context 'validating group existence' do
    it 'should be invalid if group_id not registered' do
      create(:user, id: 1, nome: 'david', password: 'herbert', email: 'ola@gmail')
      expect(build(:list_group_user, user_id: 1, group_id: 1)).to be_invalid
    end
  end

  context 'validating user in multiple groups' do
    it 'should be valid to have user in 2 or more groups' do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      create(:group, id: 1, preference_id: 1, nome: 'a', tipo: 'a', descricao: 'a')
      create(:preference, id: 2, tipo: 'teste', descricao: 'teste')
      create(:group, id: 2, preference_id: 2, nome: 'b', tipo: 'b', descricao: 'b')
      create(:user, id: 1, nome: 'david', password: 'herbert', email: 'ola@gmail')
      create(:list_group_user, user_id: 1, group_id: 1)
      expect(build(:list_group_user, user_id: 1, group_id: 2)).to be_valid
    end
  end
end
