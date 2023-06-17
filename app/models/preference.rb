class Preference < ApplicationRecord
    has_one :group, dependent: :destroy
    validates :preference_name, presence: :true, uniqueness: :true
    validates :description, presence: :true
end
