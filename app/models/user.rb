class User < ActiveRecord::Base
  has_secure_password
  has_many :players
  has_many :teams

  validates_uniqueness_of :email

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def slug
      self.full_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
      self.all.find {|i| i.slug == slug}
  end
end