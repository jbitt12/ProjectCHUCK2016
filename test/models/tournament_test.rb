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
  should allow_value(Date.current).for(:start_date)
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
      assert_equal "Project CHUCK Summer Tournament", @current_tourn.name
      assert_equal "Last year's tournament", @past_tourn.name
    end

    # End Date Validations

    should "show that date_terminated comes after date_added" do
      @valid_tourn_one = FactoryGirl.build(:tournament, name: "Valid one", start_date: 4.months.ago.to_date, end_date: 2.month.ago.to_date)
      assert @valid_group_one.valid?
      @valid_group_two = FactoryGirl.build(:tournament, name: "Valid two", start_date: 3.weeks.ago.to_date, end_date: Date.current)
      assert @valid_group_two.valid?
    end

    should "show that date_terminated cannot come before date_added or in future" do
      @invalid_group_one = FactoryGirl.build(:tournament, name: "Invalid one", start_date: 2.weeks.ago.to_date, end_date: 4.weeks.ago.to_date)
      deny @invalid_group_one.valid?
      @invalid_group_two = FactoryGirl.build(:tournament, name: "Invalid two", start_date: 2.weeks.ago.to_date, end_date: 3.years.from_now.to_date)
      deny @invalid_group_two.valid?
    end

    # Scopes

    should "show alphabetically" do
      assert_equal ["Last year's tournament", "Project CHUCK Summer Tournament"], Tournament.all.alphabetical.map{ |t| t.name }
    end

    should "show entities that are still running (current)" do
      assert_equal ["Project CHUCK Summer Tournament"], Tournament.all.current.map{ |t| t.name }
    end

    should "show entities that have ended (past)" do
      assert_equal ["Last year's tournament"], Tournament.all.past.map{ |t| t.name }
    end

    should "show entities that begin in the future (upcoming)" do
      assert_equal [], Tournament.all.upcoming.map{ |t| t.name }
      @upcoming_tourn = FactoryGirl.build(:tournament, name: "Next year's tournament", start_date: 1.year.from_now.to_date, end_date: nil)
      assert_equal ["Next year's tournament"], Tournament.all.upcoming.map{ |t| t.name }
    end

    # Services (Activeable)

    should "show active entities" do
      assert_equal ["Project CHUCK Summer Tournament"], Tournament.all.active.map{ |t| t.name }
    end

    should "show active entities" do
      assert_equal ["Next year's tournament"], Tournament.all.inactive.map{ |t| t.name }
    end

    should "make entity inactive or active" do
      assert @current_tourn.active
      @current_tourn.make_inactive
      deny @current_tourn.active
      @current_tourn.make_active
      assert @current_tourn.active
    end

    # Methods

    should "set active value of tournament , as well as toggling brackets to false if tournament is false" do
      @tourn = FactoryGirl.create(:tournament, name: "test tournament", start_date: 1.year.ago.to_date, end_date: nil)
      @brack = FactoryGirl.create(:bracket, tournament: @tourn)
      assert @tourn.active
      @tourn.update_attributes(end_date: 1.day.from_now.to_date)
      assert @tourn.active
      assert @brack.active
      @tourn.update_attributes(end_date: 1.day.ago.to_date)
      deny @tourn.active
      deny @brack.active
      @brack.destroy
      @tourn.destroy
    end

  end
end
