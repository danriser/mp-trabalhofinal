class MessageSerializer < Panko::Serializer

    attributes :user, :chat_id, :hora_de_envio, :conteudo


    def user
        {id: object.user.id, nome: object.user.nome}
    end

end