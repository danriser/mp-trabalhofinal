# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_618_184_500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'chats', force: :cascade do |t|
    t.integer 'id_match'
    t.integer 'id_group'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'groups', force: :cascade do |t|
    t.string 'nome'
    t.string 'tipo'
    t.text 'descricao'
    t.bigint 'preference_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['preference_id'], name: 'index_groups_on_preference_id'
  end

  create_table 'list_group_users', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'group_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['group_id'], name: 'index_list_group_users_on_group_id'
    t.index ['user_id'], name: 'index_list_group_users_on_user_id'
  end

  create_table 'list_preferences', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'preference_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['preference_id'], name: 'index_list_preferences_on_preference_id'
    t.index ['user_id'], name: 'index_list_preferences_on_user_id'
  end

  create_table 'matches', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'match_grade'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id2'
    t.index ['user_id'], name: 'index_matches_on_user_id'
  end

  create_table 'messages', force: :cascade do |t|
    t.bigint 'chat_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'hora_de_envio'
    t.text 'conteudo'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['chat_id'], name: 'index_messages_on_chat_id'
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'preferences', force: :cascade do |t|
    t.string 'tipo'
    t.string 'descricao'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'nome'
    t.string 'senha'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'chats', 'groups', column: 'id_group'
  add_foreign_key 'chats', 'matches', column: 'id_match'
  add_foreign_key 'groups', 'preferences'
  add_foreign_key 'list_group_users', 'groups'
  add_foreign_key 'list_group_users', 'users'
  add_foreign_key 'list_preferences', 'preferences'
  add_foreign_key 'list_preferences', 'users'
  add_foreign_key 'matches', 'users'
  add_foreign_key 'matches', 'users', column: 'user_id2'
  add_foreign_key 'messages', 'chats'
  add_foreign_key 'messages', 'users'
end
