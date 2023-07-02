# frozen_string_literal: true

#
# Model {Message}
#
# Responsavel por armazenar as mensagens
class Message < ApplicationRecord
  # @return [String] chat
  # Associação com chat.
  belongs_to :chat

  # @return [int] id do usuário
  # Associação com usuário.
  belongs_to :user

  # Valida a presença do conteúdo da mensagem.
  validates :conteudo, presence: true
end
