require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

  # Relationships
  should have_many(:brackets)

  # Presence Validations
  should validate_presence_of(:name)
  should validate_presence_of(:start_date)

  # Start Date Validations

  should allow_value(15.years.ago.to_date).for(:start_date)
  should allow_value(2.days.ago.to_date).for(:start_date)
  should_not allow_value(Date.current).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)
  should_not allow_value(nil).for(:start_date)
  
  context "Creating a context for tournaments" do

    setup do
      create_tournaments
    end

    teardown do
      remove_tournaments
    end

    # Setup Check

    should "show that all factories are properly created" do
      assert_equal "Data Governance", @data_governance.name
      assert_equal "Sales", @sales.name
      assert_equal "Marketing", @marketing.name
    end

    # End Date Validations

    should "show that date_terminated comes after date_added" do
      @valid_group_one = FactoryGirl.build(:group, name: "Valid one", organization: @passavant, date_added: 4.months.ago.to_date, date_terminated: 2.month.ago.to_date)
      assert @valid_group_one.valid?
      @valid_group_two = FactoryGirl.build(:group, name: "Valid two", organization: @passavant, date_added: 3.weeks.ago.to_date, date_terminated: Date.current)
      assert @valid_group_two.valid?
    end

    should "show that date_terminated cannot come before date_added or in future" do
      @invalid_group_one = FactoryGirl.build(:group, name: "Invalid one", organization: @passavant, date_added: 2.weeks.ago.to_date, date_terminated: 4.weeks.ago.to_date)
      deny @invalid_group_one.valid?
      @invalid_group_two = FactoryGirl.build(:group, name: "Invalid two", organization: @passavant, date_added: 2.weeks.ago.to_date, date_terminated: 3.years.from_now.to_date)
      deny @invalid_group_two.valid?
    end


end
