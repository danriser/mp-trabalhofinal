# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :match_grade

      t.timestamps
    end
  end
end
