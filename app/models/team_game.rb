class TeamGame < ActiveRecord::Base

  # Callbacks
  after_save :assign_win_loss
  before_save :check_same_bracket_team, message: "The two teams you selected are either not in the same bracket or are the same team"
  
  #Relationships
  belongs_to :team
  belongs_to :game

  #Validations
  validates_numericality_of :score, allow_blank: true

  #Custom validations
  validate :valid_team_and_game_id

  scope :chronological, -> { joins(:game).order('games.date') }

  #team_id exists in system
  #game_id exists in the system
  def valid_team_and_game_id
    all_teams = Team.all.to_a.map{|u| u.id}
    all_games = Game.all.to_a.map{|u| u.id}
    return all_teams.include?(self.team_id) && all_games.include?(self.game_id)
  end

  def check_same_bracket_team
    return true if (self.game.team_games.to_a.length == 1) # if the other team still needs a team_game, no need for this validation
    tgs = self.game.team_games
    if tgs.length != 2
      return false
    end
    team1 = tgs[0].team
    team2 = tgs[1].team
    if team1.bracket.id != team2.bracket.id
      return false
    end
    if team1.id == team2.id
      return false
    end
    true
  end

  def assign_win_loss
    return true if (self.game.team_games.to_a.length == 1) # cannot update win/loss record if the other team still needs a team_game
    tgs = self.game.team_games.to_a
    team1 = Team.all.where(id: tgs[0].team_id)[0]
    team2 = Team.all.where(id: tgs[1].team_id)[0]
    return false if tgs[0].score.nil? || tgs[1].score.nil?
    if tgs[0].score > tgs[1].score
      team1.num_wins += 1
      team2.num_losses += 1
    elsif tgs[0].score < tgs[1].score
      team1.num_losses += 1
      team2.num_wins += 1
    end
    team1.save!
    team2.save!
  end
  
end
