# frozen_string_literal: true

class UserSerializer < Panko::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :nome, :email, :list_preferences


  def list_preferences
    array_sem_edit = ListPreference.select { |usr_list_preference| usr_list_preference.user_id == object.id }
    array_com_edit = []
    for list_prefs in array_sem_edit
      array_com_edit.push({ descricao: list_prefs.preference.descricao, tipo: list_prefs.preference.tipo })
    end
    array_com_edit
  end
end
