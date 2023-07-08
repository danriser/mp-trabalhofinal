# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(nome: "Humberto", password: "123456", email: "humberto@gmail.com", is_admin: true)
User.create(nome: "Daniel", password: "teste123", email: "daniel@gmail.com")
User.create(nome: "David", password: "123", email: "david@gmail.com")
User.create(nome: "Athos", password: "athospnc", email: "athos@gmail.com")
User.create(nome: "Natalia", password: "serieb123", email: "natalia@gmail.com")

Preference.create(tipo: "Filmes", descricao: "Shrek")
Preference.create(tipo: "Filmes", descricao: "Shrek 2")
Preference.create(tipo: "Livros", descricao: "Harry Potter")
Preference.create(tipo: "Jogos", descricao: "The Last of Us")
Preference.create(tipo: "Músicas", descricao: "Pop")
Preference.create(tipo: "Programas de TV", descricao: "Friends")

ListPreference.create(id: 1, user_id: 1, preference_id: 1)
ListPreference.create(id: 2, user_id: 1, preference_id: 2)
#User.create(id: 1, nome: 'joe', senha: 'biden')
#User.create(id: 2, nome: 'barack', senha: 'obama')
#Preference.create(id: 1, tipo: 'a', descricao: 'a')
#Preference.create(id: 2, tipo: 'b', descricao: 'b')

#Group.create(id: 1, nome: 'a', tipo: 'a', descricao: 'teste', preference_id: 1)
#Group.create(id: 2, nome: 'b', tipo: 'b', descricao: 'teste', preference_id: 2)
#ListGroupUser.create(user_id: 1, group_id: 1)
#ListGroupUser.create(user_id: 2, group_id: 1)
#ListGroupUser.create(user_id: 1, group_id: 2)
#ListGroupUser.create(user_id: 2, group_id: 2)
#Chat.create(id: 1, id_match: nil, id_group: 1)
#Message.create(id: 1, chat_id: 1, user_id: 1, conteudo: 'kys')
#Message.create(id: 2, chat_id: 1, user_id: 1, conteudo: 'sorry')
#Match.create(user_id: 1, user_id2: 2, match_grade: 'a')
