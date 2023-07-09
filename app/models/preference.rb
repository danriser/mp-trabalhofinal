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
  has_one :groups, dependent: :destroy, class_name: :Group
  validates :tipo, presence: true
  validates :descricao, presence: true, uniqueness: true

  after_create :create_group

  private

  def create_group
    Group.create(nome: descricao, tipo: tipo, preference_id: id)
  end

end
