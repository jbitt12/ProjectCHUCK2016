module Contexts
  module Games

    def create_games
      @current_game = FactoryGirl.create(:game, date: Date.today)
      @past_game = FactoryGirl.create(:game, date: 2.days.ago.to_date)
      @upcoming_game = FactoryGirl.create(:game, date: 2.days.from_now)
    end

    def remove_games
      @current_game.destroy
      @past_game.destroy
      @upcoming_game.destroy
    end

  end
end
