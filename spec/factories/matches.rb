# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    user { nil }
    user2 { nil }
    match_grade { 'MyString' }
  end
end
