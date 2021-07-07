# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :auth_token
      t.timestamps
    end

    add_index :users, :auth_token, unique: true
  end
end
