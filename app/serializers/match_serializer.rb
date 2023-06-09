# frozen_string_literal: true

class MatchSerializer < Panko::Serializer
  attributes :user_1, :user_2, :match_grade

  def user_1
    { id: object.user.id, nome: object.user.nome }
  end

  def user_2
    obj = User.find(object.user_id2)
    { id: obj.id, nome: obj.nome }
  end

  def usr_list
    ids_array = ListPreference.select { |usr_list_preference| usr_list_preference.user_id == object.user_id }
  end
end
