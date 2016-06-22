class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.string :first_name
      t.string :last_name
      t.integer :household_id
      t.string :email
      t.string :cell_phone
      t.boolean :receives_text_msgs
      t.integer :user_id
      t.boolean :active
      t.string :relation
      t.boolean :is_emergency_contact

      t.timestamps
    end
  end
end
