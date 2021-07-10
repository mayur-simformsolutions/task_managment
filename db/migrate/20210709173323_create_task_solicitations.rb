class CreateTaskSolicitations < ActiveRecord::Migration[6.0]
  def change
    create_table :task_solicitations, id: :uuid do |t|
      t.references :task, null: false, foreign_key: true, type: :uuid
      t.references :solicitation, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
