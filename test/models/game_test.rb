require 'test_helper'

class GameTest < ActiveSupport::TestCase

  # Relationships
  should have_many(:team_games)
  should have_many(:teams).through(:team_games)
  
  # Value Validations
  should allow_value(15.years.ago.to_date).for(:start_date)
  should allow_value(2.days.ago.to_date).for(:start_date)
  should allow_value(Date.current).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)
  should_not allow_value(nil).for(:start_date)

  context "Creating a context for games" do

    setup do
      create_tournaments
      create_brackets
      create_teams
      create_games
      create_team_games
    end

    teardown do
      remove_team_games
      remove_games
      remove_teams
      remove_brackets
      remove_tournaments
    end

    # Setup Check

    should "show that all factories are properly created" do
      assert_equal 3, Game.all.size
    end

    # Callbacks

    should "update win/loss record of teams after game deleted" do
      assert_equal 1, @cavs.num_wins
      assert_equal 0, @cavs.num_losses
      assert_equal 0, @wars.num_wins
      assert_equal 1, @wars.num_losses
      @new_game = FactoryGirl.create(:game, date: 1.day.ago.to_date)
      @cavs_new_game = FactoryGirl.create(:team_game, game: @new_game, team: @cavs, score: 106)
      @wars_new_game = FactoryGirl.create(:team_game, game: @new_game, team: @wars, score: 99)
      assert_equal 1, @cavs.num_wins
      assert_equal 1, @cavs.num_losses
      assert_equal 1, @wars.num_wins
      assert_equal 1, @wars.num_losses
      @new_game.destroy 
      assert_equal 1, @cavs.num_wins
      assert_equal 0, @cavs.num_losses
      assert_equal 0, @wars.num_wins
      assert_equal 1, @wars.num_losses
    end

    # Scopes

    should "sort games chronologically" do
      curr_id = @current_game.id
      past_id = @past_game.id
      upco_id = @upcoming_game.id
      assert_equal [upco_id, curr_id, past_id], Game.chronological.map{ |g| g.id }
    end

    should "sort games chronologically descending" do
      curr_id = @current_game.id
      past_id = @past_game.id
      upco_id = @upcoming_game.id
      assert_equal [curr_id, curr_id, upco_id], Game.chronologicald.map{ |g| g.id }
    end

    should "show upcoming games" do
      upco_id = @upcoming_game.id
      assert_equal [upco.id], Game.upcoming.map{ |g| g.id }
    end

    should "show current games" do
      curr_id = @current_game.id
      assert_equal [curr.id], Game.current.map{ |g| g.id }
    end

    should "show past games" do
      past_id = @past_game.id
      assert_equal [past.id], Game.past.map{ |g| g.id }
    end

    # Methods

end
