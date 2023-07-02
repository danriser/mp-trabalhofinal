# frozen_string_literal: true

class ForeignKeysToChat < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :chats, :matches, column: :id_match
    add_foreign_key :chats, :groups, column: :id_group
  end
end
