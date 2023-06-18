class Preference < ApplicationRecord
    validates :tipo, presence: :true, uniqueness: :true
    validates :descricao, presence: :true
end
