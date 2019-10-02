require "spec_helper"

describe UsersController do
  describe "get /slug" do
    it "redirects to '/' if not logged in" do
      get '/nightmoves'
      expect(last_response.header['Location']).to eq("http://example.org/")
    end

    it "displays a list of teams if logged in" do
      @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
      @tigers = Team.create(name: "Tigers")
      @bob.teams << @tigers

      post '/login', {username: "nightmoves", password: "mainstreet"}

      get '/nightmoves'

      expect(last_response.body).to include("Tigers")
    end
  end

  describe 'post /slug' do
    it "creates a new team and redirects to /:slug" do
      @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")

      post '/login', {username: "nightmoves", password: "mainstreet"}
      post '/nightmoves', {name: "Badgers"}
      follow_redirect!

      expect(Team.find_by(name: "Badgers").valid?).to be(true)
      expect(last_response.body).to include("Badgers")
    end
  end
end