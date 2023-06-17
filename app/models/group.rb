class Group < ApplicationRecord
    validates :type, presence: :true
    validates :group_name, presence: :true
end
