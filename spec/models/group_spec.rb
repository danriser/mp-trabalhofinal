# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  context 'testing factory' do
    it do
      pref1 = create(:preference, tipo: 'filme', descricao: 'filme').attributes
      group = Group.find_by(preference_id: pref1['id'])

      expect(group).to be_valid
    end
  end

  context 'validating name presence' do
    it 'should be invalid if name=nil' do
      expect(build(:group, nome: nil, tipo: 'a', descricao: 'a')).to be_invalid
    end
  end

  # Como agora os grupos estão sendo criados juntos quando uma preferencia é criada, não dá mais para fazer o teste de criação de grupo isoladamente
  # context 'validating name uniqueness' do
  #  it 'should be invalid if name already taken' do
  #    create(:group, nome: 'a', tipo: 'a', descricao: 'a')
  #    expect(build(:group, nome: 'a', tipo: 'a', descricao: 'a')).to be_invalid
  #  end
  # end

  # Como agora os grupos estão sendo criados juntos quando uma preferencia é criada, não dá mais para fazer o teste de criação de grupo isoladamente
  # context 'validating preference uniqueness' do
  #  it 'should be invalid if preference already taken' do
  #    create(:preference, id: 1, tipo: 'filme', descricao: 'filme')
  #    create(:group, id: 1, preference_id: 1, nome: 'a', tipo: 'a', descricao: 'a')
  #    expect(build(:group, id: 2, preference_id: 1, nome: 'b', tipo: 'a', descricao: 'a')).to be_invalid
  #  end
  # end

  context 'validating preference existence' do
    it 'should be invalid if preference not registered' do
      expect(build(:group, id: 1, preference_id: -1, nome: 'b', tipo: 'a', descricao: 'a')).to be_invalid
    end
  end
end
