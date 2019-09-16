class Team < ActiveRecord::Base
  belongs_to :user
  has_many :players

  validate :name, :presence
end