class GroupSerializer < Panko::Serializer

    attributes :id,:nome,:descricao,:preference

    def preference
        {id: object.preference.id, tipo: object.preference.tipo, descricao: object.preference.descricao}
    end

end