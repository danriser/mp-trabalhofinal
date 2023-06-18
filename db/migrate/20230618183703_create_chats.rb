class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :id_match
      t.integer :id_group

      t.timestamps
    end
  end
end
