class Group < ApplicationRecord
  belongs_to :preference
  validates :nome, presence: :true, uniqueness: :true
  validates :preference_id, uniqueness: :true
end
