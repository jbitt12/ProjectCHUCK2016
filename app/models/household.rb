class Household < ActiveRecord::Base
  has_many :students
  has_many :guardians
end
