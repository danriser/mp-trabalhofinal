# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'testing factory' do
    it { expect(build(:user, nome: 'david', password: '123456', email: 'teste@gmail')).to be_valid }
  end

  context 'validating nome presence' do
    it 'should be invalid if nome=nil' do
      expect(build(:user, nome: nil, password: '123456', email: 'teste2@gmail')).to be_invalid
    end
  end

  context 'validating nome uniqueness' do
    it 'should be invalid if nome already taken' do
      create(:user, nome: 'david', password: '123456', email: 'teste3@gmail')
      expect(build(:user, nome: 'david', password: '123456', email: 'teste4@gmail')).to be_invalid
    end
  end

  context 'validating senha presence' do
    it 'should be invalid if senha=nil' do
      expect(build(:user, nome: 'david', password: nil, email: 'teste5@gmail')).to be_invalid
    end
  end
end
