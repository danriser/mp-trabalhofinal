class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.string :tipo
      t.string :descricao

      t.timestamps
    end
  end
end
