require 'spec_helper'

describe 'teams show page' do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @bob.teams << @tigers
    @eric = Player.create(first_name: "Eric", last_name: "Clapton")
    @jack = Player.create(first_name: "Jack", last_name: "Black")
    @tigers.players << @eric
    @tigers.players << @jack
    @bob.players << @eric
    @bob.players << @jack

    post '/login', {username: "nightmoves", password: "mainstreet"}
    get '/nightmoves/teams/1'
  end

  it "displays team info and a list of players" do
    expect(last_response.body).to include("Tigers", "Jack Black", "Eric Clapton")
  end

  it "displays a form to create a new player" do
    expect(last_response.body).to include("First Name:", "Last Name:", "Add Player")
  end
end

describe 'teams edit page' do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @bob.teams << @tigers

    post '/login', {username: "nightmoves", password: "mainstreet"}
    get '/nightmoves/teams/1/edit'
  end

  it "shows a form for editing the team" do
    expect(last_response.body).to include("Edit Team:", "Team Name:", "Tigers", "Edit Team")
  end
end