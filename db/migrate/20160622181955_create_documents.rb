class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :document
      t.string :doc_type

      t.timestamps
    end
  end
end
