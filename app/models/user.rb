# frozen_string_literal: true

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
# @attribute email
#   @return [String] o email do usuário. Usado para o login do usuário
#
# @attribute matches
#   @return [Match] as match que esse usuário possui
#
# @!attribute list_preferences
#   @return [ListPreference] lista de preferencias de usuário
#
# @attribute list_group_users
#   @return [ListGroupUser] lista dos grupos em que o usuário está
#
#
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :matches
  has_many :list_preferences
  has_many :list_group_users
  has_many :messages
  validates :nome, presence: true, uniqueness: true
  validates :email, presence: :true, uniqueness: :true
end
