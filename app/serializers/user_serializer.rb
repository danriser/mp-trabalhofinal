# frozen_string_literal: true

class UserSerializer < Panko::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :nome :list_preferences

  def list_preferences
    array_sem_edit = List_preference.select { |user_list_preference|user_list_preference.user_id == object.id }
    array_com_edit = []
    for list_preference in array_sem_edit
      array_com_edit.push({id: list_preferences.id, descricao: list_preference.descricao})
    end
    array_com_edit
  end 

end
