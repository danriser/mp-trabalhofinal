class Group < ApplicationRecord
  belongs_to :preference
  has_many :list_group_user
  validates :nome, presence: :true, uniqueness: :true
  validates :preference_id, uniqueness: :true
end
