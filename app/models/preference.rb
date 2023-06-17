class Preference < ApplicationRecord
    validates :preference_name, presence: :true, uniqueness: :true
    validates :description, presence: :true
end
