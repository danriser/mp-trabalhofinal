class CreateAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :analytics do |t|
      t.string :title
      t.integer :value

      t.timestamps
    end
  end
end
