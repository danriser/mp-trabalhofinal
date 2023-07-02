# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(id: 1, nome: 'joe', senha: 'biden')
User.create(id: 2, nome: 'barack', senha: 'obama')
Preference.create(id: 1, tipo: 'a', descricao: 'a')
Preference.create(id: 2, tipo: 'b', descricao: 'b')
ListPreference.create(id: 1, user_id: 1, preference_id: 1)
ListPreference.create(id: 2, user_id: 1, preference_id: 2)
Group.create(id: 1, nome: 'a', tipo: 'a', descricao: 'teste', preference_id: 1)
Group.create(id: 2, nome: 'b', tipo: 'b', descricao: 'teste', preference_id: 2)
ListGroupUser.create(user_id: 1, group_id: 1)
ListGroupUser.create(user_id: 2, group_id: 1)
ListGroupUser.create(user_id: 1, group_id: 2)
ListGroupUser.create(user_id: 2, group_id: 2)
Chat.create(id: 1, id_match: nil, id_group: 1)
Message.create(id: 1, chat_id: 1, user_id: 1, conteudo: 'kys')
Message.create(id: 2, chat_id: 1, user_id: 1, conteudo: 'sorry')
Match.create(user_id: 1, user_id2: 2, match_grade: 'a')
