class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :household_id
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :cell_phone
      t.string :email
      t.integer :grade
      t.string :gender
      t.text :allergies
      t.text :medications
      t.boolean :active
      t.integer :school_id
      t.string :jersey_size
      t.string :gpa
      t.integer :past_participation
      t.string :twitter
      t.string :facebook
      t.string :instagram

      t.timestamps
    end
  end
end
