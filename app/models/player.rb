class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validate :first_name, :presence
  validate :last_name, :presence

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end