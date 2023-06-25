# Humberto
class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  validates :conteudo, presence: :true
end
