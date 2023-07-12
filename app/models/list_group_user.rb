# frozen_string_literal: true

# 
# Model {ListGroupUser}
#
# É responsável por armazenar em quais grupos um usuário está e quais pessoas estão em um grupo
class ListGroupUser < ApplicationRecord
  # @return [int] id do usuário
  # Associação com usuário.
  belongs_to :user
  # @return [int] id do grupo
  # Associação com grupo.
  belongs_to :group
  validates :user_id, presence: true
  validates :group_id, presence: true
end
