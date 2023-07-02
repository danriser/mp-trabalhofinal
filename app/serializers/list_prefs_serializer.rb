# frozen_string_literal: true

class ListPrefsSerializer < Panko::Serializer
  attributes :user, :preference

  def user
    { id: object.user.id, nome: object.user.nome }
  end

  def preference
    { id: object.preference.id, tipo: object.preference.tipo }
  end
end
