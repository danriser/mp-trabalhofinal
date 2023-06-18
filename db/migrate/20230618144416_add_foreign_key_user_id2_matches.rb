class AddForeignKeyUserId2Matches < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :matches, :users, column: :user_id2
  end
end
