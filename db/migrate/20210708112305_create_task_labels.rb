# frozen_string_literal: true
class CreateTaskLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :task_labels, id: :uuid do |t|
      t.references :task, null: false, foreign_key: true, type: :uuid
      t.references :label, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
