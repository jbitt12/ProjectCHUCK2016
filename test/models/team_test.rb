require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should have_many(:roster_spots)
  should have_many(:volunteers)
  should belong_to(:bracket)
  should have_many(:team_games)
  should have_many(:students).through(:roster_spots)
  should have_many(:games).through(:team_games)

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

    should "ensure teams are eligible to play each other" do
      @not_same_bracket_game = FactoryGirl.create(:game, date:

  end 
end
