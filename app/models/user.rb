class User < ApplicationRecord
    has_many :matches
    has_many :list_preferences
    validates :nome, presence: :true, uniqueness: :true
    validates :senha, presence: :true
end
