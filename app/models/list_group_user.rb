# frozen_string_literal: true

# 
# Model {ListGroupUser}
#
# É responsável pela 
class ListGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :user_id, presence: true
  validates :group_id, presence: true
end
