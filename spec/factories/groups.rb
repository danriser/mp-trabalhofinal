# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    nome { 'MyString' }
    tipo { 'MyString' }
    descricao { 'MyText' }
    preference { nil }
  end
end
