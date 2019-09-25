class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end