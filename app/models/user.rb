class User < ApplicationRecord
    has_many :matches
    has_many :list_preferences
    has_many :list_group_user
    validates :nome, presence: :true, uniqueness: :true
    validates :senha, presence: :true
end
