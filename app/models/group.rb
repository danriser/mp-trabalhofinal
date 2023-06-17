class Group < ApplicationRecord
    belongs_to :preference
    validates :type, presence: :true
    validates :group_name, presence: :true, uniqueness: :true
    validates :description, presence: :true
    validates :preference_id, presence: :true, uniqueness: :true
end
