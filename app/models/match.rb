class Match < ApplicationRecord
    belongs_to :user
    validates :id_usuarios, presence: :true
    validates :match_grade, presence: :true
end
