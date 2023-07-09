# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListGroupUser, type: :model do
  context 'testing factory' do
    it do
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      pref = create(:preference, tipo: 'filme', descricao: 'filme').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      expect(build(:list_group_user, user_id: user['id'], group_id: group['id'])).to be_valid
    end
  end

  context 'validating user presence' do
    it 'should be invalid if user_id=nil' do
      pref = create(:preference, tipo: 'filme', descricao: 'filme').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      expect(build(:list_group_user, user_id: nil, group_id: group['id'])).to be_invalid
    end
  end

  context 'validating user existence' do
    it 'should be invalid if user_id not registered' do
      pref = create(:preference, tipo: 'filme', descricao: 'filme').attributes
      group = Group.find_by(preference_id: pref['id']).attributes
      expect(build(:list_group_user, user_id: -1, group_id: group['id'])).to be_invalid
    end
  end

  context 'validating group presence' do
    it 'should be invalid if group_id=nil' do
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:list_group_user, user_id: user['id'], group_id: nil)).to be_invalid
    end
  end

  context 'validating group existence' do
    it 'should be invalid if group_id not registered' do
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      expect(build(:list_group_user, user_id: user['id'], group_id: -1)).to be_invalid
    end
  end

  context 'validating user in multiple groups' do
    it 'should be valid to have user in 2 or more groups' do
      pref1 = create(:preference, tipo: 'filme', descricao: 'filme').attributes
      group1 = Group.find_by(preference_id: pref1['id']).attributes
      pref2 = create(:preference, tipo: 'teste', descricao: 'teste').attributes
      group2 = Group.find_by(preference_id: pref2['id']).attributes
      user = create(:user, nome: 'david', password: 'herbert', email: 'ola@gmail').attributes
      create(:list_group_user, user_id: user['id'], group_id: group1['id'])
      expect(build(:list_group_user, user_id: user['id'], group_id: group2['id'])).to be_valid
    end
  end
end
