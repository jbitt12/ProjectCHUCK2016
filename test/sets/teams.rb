module Contexts
  module Teams

    def create_teams
      @boy_cavs = FactoryGirl.create(:team, bracket: @current_male_bracket, name: "Cavs")
      @boy_wars = FactoryGirl.create(:team, bracket: @current_male_bracket, name: "Warriors")
      @girl_thunder = FactoryGirl.create(:team, bracket: @current_female_bracket, name: "Thunder")
      @girl_hawks = FactoryGirl.create(:team, bracket: @current_female_bracket, name: "Hawks")
    end

    def remove_teams
      @boy_cavs.destroy
      @boy_wizards.destroy
      @girl_thunder.destroy
      @girl_hawks.destroy
    end

  end
end
