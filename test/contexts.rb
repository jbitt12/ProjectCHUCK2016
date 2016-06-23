# require needed files
require './test/sets/brackets'
require './test/sets/documents'
require './test/sets/games'
require './test/sets/guardians'
require './test/sets/households'
require './test/sets/registrations'
require './test/sets/roster_spots'
require './test/sets/schools'
require './test/sets/students'
require './test/sets/team_games'
require './test/sets/teams'
require './test/sets/tournaments'
require './test/sets/users'
require './test/sets/volunteers'

module Contexts
  # explicitly include all sets of contexts used for testing
  include Contexts::Tournaments
  include Contexts::Brackets
  include Contexts::Teams
  include Contexts::Games
  include Contexts::Volunteers
  include Contexts::Users
  include Contexts::TeamGames
  include Contexts::Schools
  include Contexts::Guardians
  include Contexts::Households
  include Contexts::Students
  include Contexts::Documents
  include Contexts::Registrations
  include Contexts::RosterSpots
end
