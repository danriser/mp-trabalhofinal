# frozen_string_literal: true

#
# Model {List_Preference}
#
# Modelo que representa uma lista de preferências.
class ListPreference < ApplicationRecord
  # @return [int] id do usuário
  # Associação com usuário.
  belongs_to :user

  # @return [String] preferencia
  # Associação com preferência.
  belongs_to :preference
end
