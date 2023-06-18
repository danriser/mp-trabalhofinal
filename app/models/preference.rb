class Preference < ApplicationRecord
    has_many :list_preferences
    validates :tipo, presence: :true, uniqueness: :true
    validates :descricao, presence: :true
end
