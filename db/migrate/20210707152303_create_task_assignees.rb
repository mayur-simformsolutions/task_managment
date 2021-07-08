class CreateTaskAssignees < ActiveRecord::Migration[6.0]
  def change
    create_table :task_assignees, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :task, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
