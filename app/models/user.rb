class User < ActiveRecord::Base
  has_secure_password
  has_many :players
  has_many :teams

  # validates_uniqueness_of :username, message: "Username already in use"
  validates_uniqueness_of :email, message: "Email already in use"
  validates_uniqueness_of :username, message: "Username already in use"
  validates :email, presence: {message: "valid email required"}
  validates :username, length: {minimum: 8, message: "must be at least 8 characters long"}
  validates :password, length: {minimum: 8, message: "must be at least 8 characters long"}
  validates :first_name, presence: {message: "can't be blank"}
  validates :last_name, presence: {message: "can't be blank"}

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def slug
      self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
      self.all.find {|i| i.slug == slug}
  end
end