require 'test_helper'

class BracketTest < ActiveSupport::TestCase

  # Relationships
  should have_many(:teams)
  should belong_to(:tournament)
  should have_many(:registrations)
  should have_many(:students).through(:registrations)

  # Presence Validations
  should validate_presence_of(:gender)
  should validate_presence_of(:max_students)
  should validate_presence_of(:min_age)
  should validate_presence_of(:max_age)

  # Value Validations
  should allow_value(12).for(:max_students)
  should allow_value(0).for(:max_students)
  should allow_value(-12).for(:max_students)
  should_not allow_value(nil).for(:max_students)
  should_not allow_value("bad").for(:max_students)

  should allow_value(12).for(:min_age)
  should allow_value(0).for(:min_age)
  should allow_value(-12).for(:min_age)
  should_not allow_value(nil).for(:min_age)
  should_not allow_value("bad").for(:min_age)

  should allow_value(12).for(:max_age)
  should allow_value(0).for(:max_age)
  should allow_value(-12).for(:max_age)
  should_not allow_value(nil).for(:max_age)
  should_not allow_value("bad").for(:max_age)

  should allow_value("male").for(:gender)
  should allow_value("female").for(:gender)
  should_not allow_value("bad").for(:gender)
  should_not allow_value(nil).for(:gender)

  context "Creating a context for brackets" do

    setup do
      create_tournaments
      create_brackets
    end

    teardown do
      remove_brackets
      remove_tournaments
    end

    # Setup Check

    should "show that all factories are properly created" do
      assert_equal "Boys 7-10", @current_male_bracket.name
      assert_equal "Girls 7-10", @current_female_bracket.name
    end

   # Callbacks

   should "have min_age less than (or equal to) max_age" do
     @valid_age_brack = FactoryGirl.build(:bracket, min_age: 12, max_age: 13)
     assert @valid_age_brack.valid?
     @valid_age_brack2 = FactoryGirl.build(:bracket, min_age: 12, max_age: 12)
     assert @valid_age_brack.valid?
     @invalid_age_brack = FactoryGirl.build(:bracket, min_age: 12, max_age: 11)
     deny @valid_age_brack.valid?
   end

   should "be associated with active tournament" do
     assert @current_male_bracket.valid?
     @invalid_bracket = FactoryGirl.build(:bracket, tournament: @past_tourn)
     deny @invalid_bracket.valid?
   end

  # Scopes

  should "show alphabetically" do
    assert_equal ["Boys 7-10", "Girls 7-10"], Bracket.active.map{ |b| b.name }
  end

  should "show male brackets" do
    assert_equal ["Boys 7-10"], Bracket.male.map{ |b| b.name }
  end

  should "show male brackets" do
    assert_equal ["Girls 7-10"], Bracket.female.map{ |b| b.name }
  end 

  # Methods
  should "show set name" do
    assert_equal "Boys 7-10", @current_male_bracket.set_name
  end

  # TODO: Once registration contexts built... test scopes full, not_full, and method num_registered and bracket_active

  end
end
