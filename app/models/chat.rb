# frozen_string_literal: true

#
# Model {Chat}
#
# Modelo que representa um chat.
class Chat < ApplicationRecord
  # @return [String] messages
  # Associação com mensagens.
  has_many :messages
end
