class AddTeamToPlayers < ActiveRecord::Migration
  def change
    add_belongs_to :players, :team
  end
end