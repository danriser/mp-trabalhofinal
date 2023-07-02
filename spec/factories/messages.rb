# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    chat { nil }
    user { nil }
    hora_de_envio { '2023-06-18 15:45:00' }
    conteudo { 'MyText' }
  end
end
