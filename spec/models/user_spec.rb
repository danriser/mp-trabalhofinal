# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'testing factory' do
    it { expect(build(:user, nome: 'david', senha: 'teste')).to be_valid }
  end

  context 'validating nome presence' do
    it 'should be invalid if nome=nil' do
      expect(build(:user, nome: nil, senha: 'teste')).to be_invalid
    end
  end

  context 'validating nome uniqueness' do
    it 'should be invalid if nome already taken' do
      create(:user, nome: 'david', senha: 'herbert')
      expect(build(:user, nome: 'david', senha: 'herbert')).to be_invalid
    end
  end

  context 'validating senha presence' do
    it 'should be invalid if senha=nil' do
      expect(build(:user, nome: 'david', senha: nil)).to be_invalid
    end
  end
end
