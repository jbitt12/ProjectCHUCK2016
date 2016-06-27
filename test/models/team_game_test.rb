require 'test_helper'

class TeamGameTest < ActiveSupport::TestCase

  # Relationships
  should belong_to(:team)
  should belong_to(:game)
 
  # Value Validations
  should allow_value(14).for(:score)
  should allow_value(0).for(:score)
  should allow_value(nil).for(:score)
  should_not allow_value(-1).for(:score)
  should_not allow_value("bad").for(:score)
 
  context "Creating a context for teams" do

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

    should "properly setup team_game factories" do
      assert_equal "Cavs", @cavs_upcoming.team.name
      assert_equal "Warriors", @wars_upcoming.name
      assert_equal "Thunder", @thunder_current.name
      assert_equal "Hawks", @hawks_current.name
      assert_equal "Cavs", @cavs_past.team.name
      assert_equal "Warriors", @wars_past.team.name
    end

    # Callbacks

    should "update win/loss record of teams after game happens" do
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
    end

    should "ensure teams in different brackets cannot play each other" do
      @not_same_bracket_game = FactoryGirl.create(:game, date: 1.day.ago.to_date)
      @team_game = FactoryGirl.create(:team_game, team: @boy_cavs, game: @not_same_bracket_game)
      @team_game2 = FctoryGirl.create(:team_game, team: @girl_thunder, game: @not_same_bracket_game)
      deny @team_game2.valid?
    end

    should "ensure team cannot play itself" do
      @same_team_game = FactoryGirl.create(:game, date: 1.day.ago.to_date)
      @team_game_same = FactoryGirl.create(:team_game, game: @same_team_game, team: @boy_cavs)
      @team_game_same2 = FactoryGirl.create(:team_game, game: @same_team_game, team: @boy_cavs)
      deny @team_game_same2.valid?
    end

    # Custom Validation

    should "ensure association to valid team and game" do
      @valid_game = FactoryGirl.create(:game, date:2.days.ago.to_date)
      @tg_invalid_team = FactoryGirl.build(:team_game, game: @valid_game, team_id: 12321321321)
      deny @tg_invalid_team.valid?
      @tg_invalid_game = FactoryGirl.build(:team_game, game_id: 123213221, team: @boy_cavs)
      deny @tg_invalid_game.valid?
    end

    # Scope
    
    should "sort chronologically" do
      assert_equal [nil, nil, 93, 90, 94, 91], TeamGame.chronological.map{ |tg| tg.score }
    end

  end
end
