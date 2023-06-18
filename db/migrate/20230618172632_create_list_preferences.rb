class CreateListPreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :list_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :preference, null: false, foreign_key: true

      t.timestamps
    end
  end
end
