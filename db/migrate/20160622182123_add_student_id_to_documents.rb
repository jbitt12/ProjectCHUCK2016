class AddStudentIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :student_id, :integer
  end
end
