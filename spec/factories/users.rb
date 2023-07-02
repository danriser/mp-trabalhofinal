# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    nome { 'MyString' }
    senha { 'MyString' }
  end
end
