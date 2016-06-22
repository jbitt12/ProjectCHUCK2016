require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  # Relationships
  should belong_to(:household)
  should have_many(:guardians).through(:household)
  should belong_to(:school)
  should have_many(:documents)

  # Presence Validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:gender)
  should validate_presence_of(:household_id)
  should validate_presence_of(:school_id)

  # Value Validations
  should allow_value("name@me.com").for(:email)
  should allow_value("me@andrew.cmu.edu").for(:email)
  should allow_value("my_name@me.org").for(:email)
  should allow_value("name123@me.gov").for(:email)
  should allow_value("my.name@me.net").for(:email)
  should allow_value(nil).for(:email)
  
  should_not allow_value("name").for(:email)
  should_not allow_value("name@me,com").for(:email)
  should_not allow_value("name@me.uk").for(:email)
  should_not allow_value("my name@me.com").for(:email)
  should_not allow_value("name@me.con").for(:email)
  
  should allow_value("4122680000").for(:cell_phone)
  should allow_value("412-268-0000").for(:cell_phone)
  should allow_value("412.268.0000").for(:cell_phone)
  should allow_value("(412) 268-0000").for(:cell_phone)
  should allow_value(nil).for(:cell_phone)
  
  should_not allow_value("2680000").for(:cell_phone)
  should_not allow_value("4122680000x224").for(:cell_phone)
  should_not allow_value("800-EAT-FOOD").for(:cell_phone)
  should_not allow_value("412/268/0000").for(:cell_phone)
  should_not allow_value("412-2683-259").for(:cell_phone)
  
  should allow_value("4122680000").for(:emergency_contact_phone)
  should allow_value("412-268-0000").for(:emergency_contact_phone)
  should allow_value("412.268.0000").for(:emergency_contact_phone)
  should allow_value("(412) 268-0000").for(:emergency_contact_phone)

  should allow_value(15.years.ago.to_date).for(:dob) 
  should allow_value(18.years.ago.to_date).for(:dob) 
  should allow_value(6.years.ago.to_date).for(:dob) 
  should_not allow_value(2.days.ago.to_date).for(:dob)
  should_not allow_value(19.years.ago.to_date).for(:dob)
  should_not allow_value("bad").for(:dob)
  should_not allow_value(2).for(:dob)
  should_not allow_value(3.14159).for(:dob)
  should_not allow_value(nil).for(:dob)
  should_not allow_value(Date.today).for(:dob)
  should_not allow_value(1.day.from_now.to_date).for(:dob)
  
  should allow_value(1).for(:grade)
  should allow_value(0).for(:grade)
  should allow_value(11).for(:grade)
  should_not allow_value("first").for(:grade)
  should_not allow_value(-2).for(:grade)
  should_not allow_value(15).for(:grade)
  should_not allow_value(nil).for(:grade)

  context "Creating a context in preparation for Student testing" do

    setup do
      # others ...
      create_schools
      create_households
      create_students
    end

    teardown do
      remove_students
      remove_households
      remove_schools
      # others ...
    end

    # tests

  end
end
