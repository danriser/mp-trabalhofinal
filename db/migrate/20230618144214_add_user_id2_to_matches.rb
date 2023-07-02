# frozen_string_literal: true

class AddUserId2ToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :user_id2, :integer
  end
end
