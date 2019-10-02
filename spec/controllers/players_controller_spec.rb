require "spec_helper"

describe PlayersController do
  before(:each) do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @chuck = Player.create(first_name: "Chuck", last_name: "Berry")
    @bob.teams << @tigers
    @tigers.players << @chuck
    @bob.players << @chuck
  end

  it "gets the player info if logged in" do
    post '/login', {username: "nightmoves", password: "mainstreet"}
    follow_redirect!
    get "/nightmoves/teams/1/players/1"

    expect(last_response.body).to include("Chuck Berry", "Coach", "Bob Seger", "Team", "Tigers")
  end

  it "redirects to / if not logged in" do
    get "/nightmoves/teams/1/players/1"

    expect(last_response.status).to eq(302)
    follow_redirect!
    expect(last_request.env['PATH_INFO']).to eq('/')
  end

  it "changes the player's name and redirects to player page" do
    post "/login", {username: "nightmoves", password: "mainstreet"}
    patch "/nightmoves/teams/1/players/1", {
      first_name: "Angus", last_name: "Young"
    }

    expect(Player.find(1).full_name).to eq("Angus Young")
    expect(last_response.status).to eq(302)
    follow_redirect!

    expect(last_request.env["PATH_INFO"]).to eq("/nightmoves/teams/1")
  end

  it "displays a form for changing the team for edit" do
    post "/login", {username: "nightmoves", password: "mainstreet"}
    get "/nightmoves/teams/1/players/1/edit"

    expect(last_response.body).to include("Edit Player:")
  end

  it "deletes the player and redirects to /:slug" do
    post "/login", {username: "nightmoves", password: "mainstreet"}
    player_count = Player.all.size
    
    delete '/nightmoves/teams/1/players/1/delete'

    expect(Player.all.size).to eq(player_count - 1)
    expect(last_response.status).to eq(302)
    follow_redirect!

    expect(last_request.env["PATH_INFO"]).to eq("/nightmoves/teams/1")
  end
end