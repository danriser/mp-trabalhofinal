# frozen_string_literal: true

#
# Model {Preference}
#
# Responsável por armazenar os dados de uma preferencia
#
# @attribute id
#   @return [int] id da preferencia
#
# @attribute tipo
#   @return [String] tipo de preferencia
#
# @attribute descricao
#   @return [String] descricao de uma preferencia
#
#
class Preference < ApplicationRecord
  has_many :list_preferences
  has_one :groups
  validates :tipo, presence: true, uniqueness: true
  validates :descricao, presence: true
end
