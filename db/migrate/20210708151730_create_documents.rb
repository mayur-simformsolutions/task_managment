class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents, id: :uuid do |t|
      t.references :task, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.timestamps
    end
  end
end
