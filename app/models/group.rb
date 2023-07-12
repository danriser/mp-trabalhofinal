# frozen_string_literal: true

# 
# Model {Group} 
#
# Modelo que representa um grupo 
class Group < ApplicationRecord
  # @return [int] id da preferencia
  # Associação com preferencia.
  belongs_to :preference

  # @return [int] ids do usuários pertencentes ao grupo
  # Associação com usuário.
  has_many :list_group_user

  # @return [String] nome do grupo
  validates :nome, presence: true, uniqueness: true
  validates :preference_id, uniqueness: true
end
