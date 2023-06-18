class Preference < ApplicationRecord
    has_many :list_preferences
    has_one :groups
    validates :tipo, presence: :true, uniqueness: :true
    validates :descricao, presence: :true
end
