require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  # Relationships
  should have_many(:roster_spots)
  should have_many(:volunteers)
  should belong_to(:bracket)
  should have_many(:team_games)
  should have_many(:students).through(:roster_spots)
  should have_many(:games).through(:team_games)

  # Basic Validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  # Value Validations
  should allow_value(14).for(:num_wins)
  should allow_value(0).for(:num_wins)
  should allow_value(nil).for(:num_wins)
  should_not allow_value(-1).for(:num_wins)
  should_not allow_value("bad").for(:num_wins)

  should allow_value(14).for(:num_losses)
  should allow_value(0).for(:num_losses)
  should allow_value(nil).for(:num_losses)
  should_not allow_value(-1).for(:num_losses)
  should_not allow_value("bad").for(:num_losses)

  should allow_value(14).for(:num_wins)
  should allow_value(0).for(:num_wins)
  should_not allow_value(nil).for(:num_wins)
  should_not allow_value(-1).for(:num_wins)
  should_not allow_value("bad").for(:num_wins)

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
    should "properly setup team factories" do
      assert_equal "Cavs", @boys_cavs.name
      assert_equal "Warriors", @boys_wars.name
      assert_equal "Thunder", @girls_thunder.name
      assert_equal "Hawks", @girls_hawks.name
    end

    # Custom Validations

    should "ensure team added to active bracket" do
      @active_bracket = FactoryGirl.create(:bracket, tournament: @current_tourn, active: true)
      @valid_team = FactoryGirl.build(:team, bracket: @active_bracket)
      assert @valid_team.valid?
      @inactive_bracket = FactoryGirl.create(:bracket, tournament: @current_tourn, active: false)
      @invalid_team = FactoryGirl.build(:team, bracket: @inactive_bracket)
      deny @invalid_team.valid?
      @inactive_bracket.destroy
    end

    should "make sure there's space in the bracket" do
      # TODO
    end

    # Callbacks

    should "make nil values 0 for wins/losses" do
      @team_temp = FactoryGirl.build(:team, num_wins: nil)
      assert_equal 0, @team_temp.num_wins
      @other_temp_team = FactoryGirl.build(:team, num_losses: nil)
      assert_equal 0, @other_temp_team.num_losses
    end

     # Scopes

     should "sort alphabetically" do
       assert_equal ["Cavs", "Hawks", "Thunder", "Warriors"], Team.alphabetical.map{ |t| t.name }
     end

     should "sort by wins, losses, or both" do
       @new_game = FactoryGirl.create(:game, date: 1.day.ago_to_date)
       @tg_cavs = FactoryGirl.create(:team_game, game: @new_game, team: @boy_cavs, score: 109)
       @tg_wars = FactoryGirl.create(:team_game, game: @new_game, team: @boy_wars, score: 102)
       @new_game2 = FactoryGirl.create(:game, date: 1.day.ago_to_date)
       @tg_cavs = FactoryGirl.create(:team_game, game: @new_game2, team: @girl_thunder, score: 117)
       @tg_wars = FactoryGirl.create(:team_game, game: @new_game2, team: @girl_hawks, score: 88)
       assert_equal "Cavs", Team.wins.map{ |t| t.name }.first # cavs have most wins
       assert_equal "Hawks", Team.wins.map{ |t| t.name }.last # hawks have least wins
       assert_equal "Hawks", Team.losses.map{ |t| t.name }.first # hawks have most losses
       assert_equal "Cavs", Team.losses.map{ |t| t.name }.last # cavs have least losses
       @new_game3 = FactoryGirl.create(:game, date: 1.day.ago_to_date)
       @tg_cavs = FactoryGirl.create(:team_game, game: @new_game3, team: @girl_thunder, score: 90)
       @tg_wars = FactoryGirl.create(:team_game, game: @new_game3, team: @girl_hawks, score: 94)
       assert_equal "Cavs", Team.standings.map{ |t| t.name }.first # cavs are 2-0
       assert_equal "Thunder", Team.standings.map{ |t| t.name }.second # thunder are 2-1
     end

     # NOTE: Difficult to test due to uncertainty or ID numbers
     should "sort by bracket" do
       assert_equal Team.by_bracket.map{ |t| t.bracket_id }.first, Team.by_bracket.map{ |t| t.bracket_id }.second
     end

     # Other methods

     # TODO: Test methods involving RosterSpot

  end 
end
