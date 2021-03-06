#NOTE: seems to have a bunch of errors

class Game < ActiveRecord::Base

  # before_save :update_records, on: :update
  # before_save :check_score, on: [:update, :create]
  before_destroy :remove_win_loss

  #Relationship Validations
  has_many :team_games
  has_many :teams, through: :team_games

  accepts_nested_attributes_for :team_games, reject_if: lambda { |team_game| team_game[:team_id].blank? }, allow_destroy: true
  
  #Validations
  validates_date :date
  #validate :date_after_tourney_start 

  #Scopes
  scope :chronological, -> { order('date') }
  scope :chronologicald, -> { order('date desc') }
  scope :current, -> { where("? <= date and date <= ?", DateTime.new(Date.today.year,Date.today.month,Date.today.day,0,0,0), DateTime.new(Date.tomorrow.year,Date.tomorrow.month,Date.tomorrow.day,0,0,0)) }
  scope :past, -> { where("date < ?", DateTime.new(Date.today.year,Date.today.month,Date.today.day,0,0,0)) }
  scope :upcoming, -> { where("date > ?", DateTime.new(Date.tomorrow.year,Date.tomorrow.month,Date.tomorrow.day,0,0,0)) }

  private

  #NEED TO DO JOINS FOR THIS CUZ IT AINT WORKING
  #def date_after_tourney_start
  #   tstart = self.teams.to_a[1].bracket.tournament.start_date
  #   return date >= tstart
  #end

  #def check_same_bracket_team
  #  tgs = self.team_games
  #  if tgs.length != 2
  #    return false
  #  end
  #  team1 = tgs[0].team
  #  team2 = tgs[1].team
  #  if team1.bracket != team2.bracket
  #    return false
  #  end
  #  if team1 == team2
  #    return false
  #  end
  #  true
  #end

  #def check_score
  #  self.team_games.to_a.each do |tg|
  #    if tg.score.nil?
  #      tg.score = 0
  #      tg.save!
  #    end
  #  end
  #end

  # This commetned out version of assign_win_loss resets the win/loss record for each team and goes through every game to re-compute it
  #
  # def assign_win_loss
  #   tgs = self.team_games.to_a
  #   team1 = Team.all.where(id: tgs[0].team_id)[0]
  #   team2 = Team.all.where(id: tgs[1].team_id)[0]
  #   team1.num_wins = 0
  #   team2.num_wins = 0
  #   team1.num_losses = 0
  #   team2.num_losses = 0
  #   Game.all.each do |game|
  #     gtgs = game.team_games
  #     t1_flag = false
  #     t2_flag = false
  #     gtgs.each do |gtg|
  #       if gtg.team_id == team1.id
  #         t1_flag = true
  #       end
  #       if gtg.team_id == team2.id
  #         t2_flag = true
  #       end
  #     end
  #     if t1_flag
  #       if gtgs[0].team_id == team1.id
  #         if gtgs[0].score > gtgs[1].score
  #           team1.num_wins += 1
  #         elsif gtgs[0].score < gtgs[1].score
  #           team1.num_losses += 1
  #         end
  #       else
  #          if gtgs[0].score < gtgs[1].score
  #           team1.num_wins += 1
  #         elsif gtgs[0].score > gtgs[1].score
  #           team1.num_losses += 1
  #         end
  #       end
  #     end
  #     if t2_flag
  #       if gtgs[0].team_id == team2.id
  #         if gtgs[0].score > gtgs[1].score
  #           team2.num_wins += 1
  #         elsif gtgs[0].score < gtgs[1].score
  #           team2.num_losses += 1
  #         end
  #       else
  #          if gtgs[0].score < gtgs[1].score
  #           team2.num_wins += 1
  #         elsif gtgs[0].score > gtgs[1].score
  #           team2.num_losses += 1
  #         end
  #       end
  #     end
  #   end
  #   team1.save!
  #   team2.save!
  # end

  #def assign_win_loss
  #  tgs = self.team_games.to_a
  #  team1 = Team.all.where(id: tgs[0].team_id)[0]
  #  team2 = Team.all.where(id: tgs[1].team_id)[0]
  #  return false if tgs[0].score.nil? || tgs[1].score.nil?
  #  if tgs[0].score > tgs[1].score
  #    team1.num_wins += 1
  #    team2.num_losses += 1
  #  elsif tgs[0].score < tgs[1].score
  #    team1.num_losses += 1
  #    team2.num_wins += 1
  #  end
  #  team1.save!
  #  team2.save!
  #end

  def remove_win_loss
    tgs = self.team_games.to_a
    return true if (tgs.length != 2)
    team1 = Team.all.where(id: tgs[0].team_id)[0]
    team2 = Team.all.where(id: tgs[1].team_id)[0]
    return true if tgs[0].score.nil? || tgs[1].score.nil?
    if tgs[0].score > tgs[1].score
      team1.num_wins -= 1
      team2.num_losses -= 1
    elsif tgs[0].score < tgs[1].score
      team1.num_losses -= 1
      team2.num_wins -= 1
    end
    team1.save!
    team2.save!
    true
  end
  
end

