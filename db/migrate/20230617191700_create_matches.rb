class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :id_usuarios
      t.integer :match_grade

      t.timestamps
    end
  end
end
