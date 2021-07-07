# frozen_string_literal: true
class AddDeviseToUsers < ActiveRecord::Migration[6.0]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
     
    end

    add_index :users, :email,                unique: true
    add_index :users, :confirmation_token,   unique: true
  end
end
