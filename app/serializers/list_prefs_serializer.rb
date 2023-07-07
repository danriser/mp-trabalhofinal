# frozen_string_literal: true

class ListPrefsSerializer < Panko::Serializer
  attributes :user, :preference

  def user
    { nome: object.user.nome }
  end

  def preference
    { descricao: object.preference.descricao, tipo: object.preference.tipo }
  end
end
