# NOTE: If we make a bracket inactive and then save it then the registrations related to
# that bracket are made inactive. But if the bracket is made active from inactive then
# the registrations are not affected. 

require "activeable"
class Bracket < ActiveRecord::Base
include Activeable

  #Callbacks
  before_validation :valid_tournament_id, on: :create
  before_save :set_name
  after_save :bracket_active

  #Relationships 
  has_many :teams
  belongs_to :tournament
  has_many :registrations
  has_many :students, through: :registrations

  #Validations
  GENDER_ARRAY = ["male","female"]

  validates :gender, inclusion: { in: GENDER_ARRAY, allow_blank: false }

  validates_presence_of :gender, :max_students, :min_age, :max_age
  validates_numericality_of :max_students, :min_age, :max_age
  validate :minlessmax

  # Scopes
  scope :alphabetical, -> { order('gender, min_age') }
  # by gender 
  scope :male, -> { where("gender = ?","male") }
  scope :female, -> { where("gender = ?", "female") }

  #by age group
  #this needs some clarification 

  #is full
  scope :full, -> { where("max_students = ? ", num_registered) }
  scope :not_full, -> { where("max_students > ?", num_registered) }

  private 
  #Custom validations

  def set_name
    self.name = "#{self.gender.camelize}: #{self.min_age}-#{self.max_age}"
  end

  def bracket_active
    if (self.active == false)
      regs = Registration.where('bracket_id = ?', self.id)
      regs.each do |reg|
        reg.active = false
        reg.save!
      end
    end
  end

  def minlessmax
    return self.min_age <= self.max_age 
  end

  # be associated with active tournament
  def valid_tournament_id
    all_tournaments = Tournament.all.active.to_a.map{|u| u.id}
    return all_tournaments.include?(self.tournament.id)
  end

  #HELPER FUNCTIONS
  def num_registered
    return self.registrations.to_a.length
  end 

end
