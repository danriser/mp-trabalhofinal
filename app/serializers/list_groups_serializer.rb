class ListGroupsSerializer < Panko::Serializer

    attributes :user, :group

    def user
        {id: object.user.id, nome: object.user.nome}
    end

    def group
        {id: object.group.id, nome: object.group.nome}
    end

end