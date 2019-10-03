require 'spec_helper'

describe 'players show page' do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @bob.teams << @tigers
    @eric = Player.create(first_name: "Eric", last_name: "Clapton")
    @tigers.players << @eric
    @bob.players << @eric

    post '/login', {username: "nightmoves", password: "mainstreet"}
    get '/nightmoves/teams/1/players/1'
  end

  it "displays player info" do
    expect(last_response.body).to include("Eric Clapton", "Tigers", "Bob Seger")
  end
end

describe 'players edit page' do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @bob.teams << @tigers
    @eric = Player.create(first_name: "Eric", last_name: "Clapton")
    @tigers.players << @eric
    @bob.players << @eric

    post '/login', {username: "nightmoves", password: "mainstreet"}
    get '/nightmoves/teams/1/players/1/edit'
  end

  it "shows a form for editing the team" do
    expect(last_response.body).to include("Edit Player:", "First Name:", "Eric", "Last Name:", "Clapton", "Edit Player")
  end
end