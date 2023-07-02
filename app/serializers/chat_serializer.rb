# frozen_string_literal: true

class ChatSerializer < Panko::Serializer
  attributes :match, :group

  def match
    unless object.id_match.nil?
      obj = Match.find(object.id_match)
      return { id: obj.id, user_id: obj.user_id, user_id2: obj.user_id2 }
    end
    nil
  end

  def group
    unless object.id_group.nil?
      obj = Group.find(object.id_group)
      return { id: obj.id, nome: obj.nome }
    end
    nil
  end
end
