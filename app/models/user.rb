class User < ApplicationRecord
    has_many :matches
    validates :nome, presence: :true, uniqueness: :true
    validates :senha, presence: :true
end
