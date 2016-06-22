class Student < ActiveRecord::Base
  belongs_to :household
  has_many :guardians, through: :household
  belongs_to :school
  has_many :documents
end
