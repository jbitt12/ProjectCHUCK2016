class Guardian < ActiveRecord::Base
  belongs_to :household
  has_many :students, through: :household
  belongs_to :user
end
