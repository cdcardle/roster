class AddUserToPlayers < ActiveRecord::Migration
  def change
    add_belongs_to :players, :user
  end
end