module Contexts
  module TeamGames

    def create_team_games
      @cavs_upcoming = FactoryGirl.create(:team_game, team: @boy_cavs, game: @upcoming_game)
      @wars_upcoming = FactoryGirl.create(:team_game, team: @boy_wars, game: @upcoming_game)
      @cavs_past = FactoryGirl.create(:team_game, team: @boy_cavs, game: @past_game, score: 94)
      @wars_past = FactoryGirl.create(:team_game, team: @boy_wars, game: @past_game, score: 91)
      @thunder_current = FactoryGirl.create(:team_game, team: @girl_thunder, game: @current_game, score: 93)
      @hawks_current = FactoryGirl.create(:team_game, team: @girl_hawks, game: @current_game, score: 90)
    end

    def remove_team_games
      @cavs_upcoming.destroy
      @wars_upcoming.destroy
      @cavs_past.destroy
      @wars_past.destroy
      @thunder_current.destroy
      @hawks_current.destroy
    end

  end
end
