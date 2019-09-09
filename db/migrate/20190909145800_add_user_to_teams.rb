class AddUserToTeams < ActiveRecord::Migration
  def change
    add_belongs_to :teams, :user
  end
end