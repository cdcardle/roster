require 'spec_helper'

describe 'users show page' do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @bob.teams << @tigers
    post '/login', {username: "nightmoves", password: "mainstreet"}
    get '/nightmoves'
  end

  it "welcomes the coach back and shows a list of their teams" do
    expect(last_response.body).to include("Welcome back, Coach Seger!", "Tigers")
  end

  it "displays a form to create a new team" do
    expect(last_response.body).to include("Team Name:", "Name...", "Create Team")
  end
end