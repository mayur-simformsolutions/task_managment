# frozen_string_literal: true
class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title
      t.date :due_date
      t.text :description
      t.integer :status, default: 0
      t.uuid :creator_id, index: true
      t.timestamps
    end
  end
end
