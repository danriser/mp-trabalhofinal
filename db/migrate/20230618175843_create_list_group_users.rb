class CreateListGroupUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :list_group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
