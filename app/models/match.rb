# Enzo
class Match < ApplicationRecord
  belongs_to :user
  validates :match_grade, presence: :true
  validates :user_id, presence: :true
  validates :user_id2, presence: :true
end
