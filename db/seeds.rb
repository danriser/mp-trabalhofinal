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

Preference.create(tipo: "Filmes", descricao: "Interestelar")
Preference.create(tipo: "Filmes", descricao: "Guardiões da Galáxia")
Preference.create(tipo: "Filmes", descricao: "O Grande Hotel Budapeste")
Preference.create(tipo: "Filmes", descricao: "A Origem")
Preference.create(tipo: "Filmes", descricao: "Dunkirk")
Preference.create(tipo: "Filmes", descricao: "Deadpool")
Preference.create(tipo: "Filmes", descricao: "Clube da Luta")
Preference.create(tipo: "Filmes", descricao: "O Lobo de Wallstreet")
Preference.create(tipo: "Filmes", descricao: "Blade Runner 2049")
Preference.create(tipo: "Filmes", descricao: "Django Livre")
Preference.create(tipo: "Filmes", descricao: "Logan")
Preference.create(tipo: "Filmes", descricao: "Birdman")
Preference.create(tipo: "Filmes", descricao: "Bastardos Inglórios")
Preference.create(tipo: "Filmes", descricao: "Star Wars")
Preference.create(tipo: "Filmes", descricao: "Mulher-Maravilha")
Preference.create(tipo: "Filmes", descricao: "Perdido em Marte")
Preference.create(tipo: "Filmes", descricao: "Drive")
Preference.create(tipo: "Filmes", descricao: "O Iluminado")
Preference.create(tipo: "Filmes", descricao: "O Regresso")
Preference.create(tipo: "Filmes", descricao: "The Avengers: Os Vingadores")
Preference.create(tipo: "Filmes", descricao: "O Poderoso Chefão")
Preference.create(tipo: "Filmes", descricao: "Pantera Negra")
Preference.create(tipo: "Filmes", descricao: "O Abutre")
Preference.create(tipo: "Filmes", descricao: "Os Oito Odiados")
Preference.create(tipo: "Filmes", descricao: "Alien, o Oitavo Passageiro")
Preference.create(tipo: "Filmes", descricao: "A Rede Social")
Preference.create(tipo: "Filmes", descricao: "2001: Uma Odisseia no Espaço")
Preference.create(tipo: "Filmes", descricao: "Gravidade")
Preference.create(tipo: "Filmes", descricao: "Kill Bill: Vol. 1")
Preference.create(tipo: "Filmes", descricao: "It: A Coisa")
Preference.create(tipo: "Filmes", descricao: "O Silêncio dos Inocentes")
Preference.create(tipo: "Filmes", descricao: "Zootopia - Essa Cidade é o Bicho")
Preference.create(tipo: "Filmes", descricao: "Se7en - Os Sete Crimes Capitais")
Preference.create(tipo: "Filmes", descricao: "De Volta para o Futuro")
Preference.create(tipo: "Filmes", descricao: "Kingsman: Serviço Secreto")
Preference.create(tipo: "Filmes", descricao: "Doutor Estranho")
Preference.create(tipo: "Filmes", descricao: "Onde os Fracos Não Têm Vez")
Preference.create(tipo: "Filmes", descricao: "Matrix")
Preference.create(tipo: "Filmes", descricao: "Jurassic Park: O Parque dos Dinossauros")
Preference.create(tipo: "Filmes", descricao: "Cisne Negro")
Preference.create(tipo: "Filmes", descricao: "Forrest Gump: O Contador de Histórias")
Preference.create(tipo: "Filmes", descricao: "A Viagem de Chihiro")
Preference.create(tipo: "Filmes", descricao: "Um Sonho de Liberdade")
Preference.create(tipo: "Filmes", descricao: "O Quarto de Jack")
Preference.create(tipo: "Filmes", descricao: "O Grande Lebowski")
Preference.create(tipo: "Filmes", descricao: "Amnésia")
Preference.create(tipo: "Filmes", descricao: "Cães de Aluguel")
Preference.create(tipo: "Filmes", descricao: "Scott Pilgrim Contra o Mundo")
Preference.create(tipo: "Filmes", descricao: "Laranja Mecânica")
Preference.create(tipo: "Filmes", descricao: "Os Bons Companheiros")
Preference.create(tipo: "Filmes", descricao: "Esquadrão Suicida")
Preference.create(tipo: "Filmes", descricao: "Sangue Negro")
Preference.create(tipo: "Filmes", descricao: "WALL-E")
Preference.create(tipo: "Filmes", descricao: "Donnie Darko")
Preference.create(tipo: "Filmes", descricao: "Beleza Americana")
Preference.create(tipo: "Filmes", descricao: "Viva - A Vida é uma Festa")
Preference.create(tipo: "Filmes", descricao: "Em Ritmo de Fuga")
Preference.create(tipo: "Filmes", descricao: "La La Land: Cantando Estações")
Preference.create(tipo: "Filmes", descricao: "Corra!")
Preference.create(tipo: "Filmes", descricao: "A Chegada")

Preference.create(tipo: "Livros", descricao: "Com amor, Simon")
Preference.create(tipo: "Livros", descricao: "O homem mais rico da Babilônia")
Preference.create(tipo: "Livros", descricao: "Um experimento de amor em Nova York")
Preference.create(tipo: "Livros", descricao: "Antes que o café esfrie")
Preference.create(tipo: "Livros", descricao: "Café com Deus Pai")
Preference.create(tipo: "Livros", descricao: "Verity")
Preference.create(tipo: "Livros", descricao: "A hora da estrela")
Preference.create(tipo: "Livros", descricao: "É assim que começa")
Preference.create(tipo: "Livros", descricao: "A Biblioteca da Meia-Noite")
Preference.create(tipo: "Livros", descricao: "Vermelho, branco e sangue azul")
Preference.create(tipo: "Livros", descricao: "É assim que acaba")
Preference.create(tipo: "Livros", descricao: "Gatilhos Mentais")
Preference.create(tipo: "Livros", descricao: "Amêndoas")
Preference.create(tipo: "Livros", descricao: "Um dia muito mal-humorado")
Preference.create(tipo: "Livros", descricao: "Os segredos da mente milionária")
Preference.create(tipo: "Livros", descricao: "Heartstopper")
Preference.create(tipo: "Livros", descricao: "1984")
Preference.create(tipo: "Livros", descricao: "A revolução dos bichos: Um conto de fadas")
Preference.create(tipo: "Livros", descricao: "Todas as suas (im)perfeições")
Preference.create(tipo: "Livros", descricao: "Melhor do que nos filmes")
Preference.create(tipo: "Livros", descricao: "Os miseráveis")
Preference.create(tipo: "Livros", descricao: "Tudo é rio")
Preference.create(tipo: "Livros", descricao: "Torto arado")
Preference.create(tipo: "Livros", descricao: "Cartas de um diabo a seu aprendiz")
Preference.create(tipo: "Livros", descricao: "Até o verão terminar")
Preference.create(tipo: "Livros", descricao: "Fahrenheit 451")

<<<<<<< HEAD

#User.create(id: 1, nome: 'joe', senha: 'biden')
#User.create(id: 2, nome: 'barack', senha: 'obama')
#Preference.create(id: 1, tipo: 'a', descricao: 'a')
#Preference.create(id: 2, tipo: 'b', descricao: 'b')
ListPreference.create(id: 1, user_id: 1, preference_id: 1)
ListPreference.create(id: 2, user_id: 1, preference_id: 2)
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
=======
Preference.create(tipo: "Jogos", descricao: "")
Preference.create(tipo: "Músicas", descricao: "")
Preference.create(tipo: "Programas de TV", descricao: "")

# User.create(id: 1, nome: 'joe', senha: 'biden')
# User.create(id: 2, nome: 'barack', senha: 'obama')
# Preference.create(id: 1, tipo: 'a', descricao: 'a')
# Preference.create(id: 2, tipo: 'b', descricao: 'b')
# ListPreference.create(id: 1, user_id: 1, preference_id: 1)
# ListPreference.create(id: 2, user_id: 1, preference_id: 2)
# Group.create(id: 1, nome: 'a', tipo: 'a', descricao: 'teste', preference_id: 1)
# Group.create(id: 2, nome: 'b', tipo: 'b', descricao: 'teste', preference_id: 2)
# ListGroupUser.create(user_id: 1, group_id: 1)
# ListGroupUser.create(user_id: 2, group_id: 1)
# ListGroupUser.create(user_id: 1, group_id: 2)
# ListGroupUser.create(user_id: 2, group_id: 2)
# Chat.create(id: 1, id_match: nil, id_group: 1)
# Message.create(id: 1, chat_id: 1, user_id: 1, conteudo: 'kys')
# Message.create(id: 2, chat_id: 1, user_id: 1, conteudo: 'sorry')
# Match.create(user_id: 1, user_id2: 2, match_grade: 'a')
>>>>>>> 122eba806abd97a8ba1bb8954224a5c574fc7b1f
