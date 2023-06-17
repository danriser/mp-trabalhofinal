class ModificaGrupos < ActiveRecord::Migration[7.0]
  def change
    change_table :groups do |t|
      t.change :preference_id , :string
  end
end
end
