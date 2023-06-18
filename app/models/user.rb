class User < ApplicationRecord
    validates :nome, presence: :true, uniqueness: :true
    validates :senha, presence: :true
end
