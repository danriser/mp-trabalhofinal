#
# Model {User} 
#
# Responsável por armazenar os dados de um usuário
#
# @attribute id
#   @return [int] id do usuário
#
# @attribute nome
#   @return [String] nome do usuário
#
#
#
#
#
#
class User < ApplicationRecord 
    has_many :matches
    has_many :list_preferences
    has_many :list_group_users
    has_many :messages
    validates :nome, presence: :true, uniqueness: :true
    validates :senha, presence: :true
end
