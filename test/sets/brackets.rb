module Contexts
  module Brackets

    def create_brackets
      @current_male_bracket = FactoryGirl.create(:bracket, tournament: @current_tourn)
      @current_female_bracket = FactoryGirl.create(:bracket, tournament: @current_tourn, gender: "female", name: "Girls 7-10")
    end

    def remove_brackets
      @current_male_bracket.destroy
      @current_female_bracket.destroy
    end

  end
end
