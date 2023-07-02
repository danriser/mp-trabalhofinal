# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'testing factory' do
    it do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      expect(build(:group, id: 1, nome: 'marvel', tipo: 'privado', descricao: 'DC mt melhor',
                           preference_id: 1)).to be_valid
    end
  end

  context 'validating name presence' do
    it 'should be invalid if name=nil' do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      expect(build(:group, id: 1, preference_id: 1, nome: nil, tipo: 'a', descricao: 'a')).to be_invalid
    end
  end

  context 'validating name uniqueness' do
    it 'should be invalid if name already taken' do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      create(:preference, id: 2, tipo: 'serie', descricao: 'serie')
      create(:group, id: 1, preference_id: 1, nome: 'a', tipo: 'a', descricao: 'a')
      expect(build(:group, id: 2, preference_id: 2, nome: 'a', tipo: 'a', descricao: 'a')).to be_invalid
    end
  end

  context 'validating preference uniqueness' do
    it 'should be invalid if preference already taken' do
      create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
      create(:group, id: 1, preference_id: 1, nome: 'a', tipo: 'a', descricao: 'a')
      expect(build(:group, id: 2, preference_id: 1, nome: 'b', tipo: 'a', descricao: 'a')).to be_invalid
    end
  end

  context 'validating preference existence' do
    it 'should be invalid if preference not registered' do
      expect(build(:group, id: 1, preference_id: 1, nome: 'b', tipo: 'a', descricao: 'a')).to be_invalid
    end
  end
end
