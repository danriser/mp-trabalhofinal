# frozen_string_literal: true

# 
# Model {Match}
#
# Responsável por armazenar um possível match entre usuários
#
# @attribute match_grade
#   @return [float] a nota que reflete o quão parecido os dois usuários são
#
# @attribute user_id
#   @return [User] um dos usuários do match
#
# @attribute user_id2
#   @return [User] um dos usuários do match
#
class Match < ApplicationRecord
  belongs_to :user
  validates :match_grade, presence: true
  validates :user_id, presence: true
  validates :user_id2, presence: true
end
