class ChatSerializer < Panko::Serializer

    attributes :match, :group

    def match
        if(object.id_match!=nil)
            obj=Match.find(object.id_match)
            return {id: obj.id, user_id: obj.user_id, user_id2: obj.user_id2}
        end
        return nil
    end

    def group
        if(object.id_group!=nil)
            obj=Group.find(object.id_group)
            return {id: obj.id, nome: obj.nome}
        end
        return nil
    end


end