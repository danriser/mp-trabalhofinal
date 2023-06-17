FactoryBot.define do
  factory :group do
    type { "" }
    group_name { "MyString" }
    description { "MyText" }
    preference_id { 1 }
  end
end
