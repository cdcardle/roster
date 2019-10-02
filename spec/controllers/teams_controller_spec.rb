require "spec_helper"

describe TeamsController do
  describe "/:slug/teams/:team_id" do
    describe "get" do
      before(:each) do
        @tom = User.create(first_name: "Tom", last_name: "Petty", email: "heartbreakers101@hotmail.com", username: "breakdown", password: "freefallin")
        @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
        @tigers = Team.create(name: "Tigers")
        @bob.teams << @tigers
      end

      it "get should display team info if logged in as that team's coach" do
        post "/login", {username: "nightmoves", password: "mainstreet"}

        get "/#{@bob.slug}/teams/#{@tigers.id}"

        expect(last_response.body).to include("<h1>Tigers</h1>")
        expect(last_response.body).to include("<p>Bob Seger</p>")
      end

      it "redirects to '/' if not logged in" do
        get "/#{@bob.slug}/teams/#{@tigers.id}"

        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.env["PATH_INFO"]).to eq("/")
      end

      it "redirects to '/' if logged in as a different coach" do
        post "/login", {username: "breakdown", password: "freefallin"}

        get "/#{@bob.slug}/teams/#{@tigers.id}"

        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.env["PATH_INFO"]).to eq("/")
      end
    end

    describe "post" do
      before(:each) do
        @tom = User.create(first_name: "Tom", last_name: "Petty", email: "heartbreakers101@hotmail.com", username: "breakdown", password: "freefallin")
        @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
        @tigers = Team.create(name: "Tigers")
        @bob.teams << @tigers
      end

      it "creates a player and adds it to the team" do
        player_count = Player.all.size

        post "/#{@bob.slug}/teams/#{@tigers.id}", {
          first_name: "Angus", last_name: "Young"
        }

        expect(Player.all.size).to eq(player_count + 1)
        expect(@tigers.players).to include(Player.find_by(first_name: "Angus", last_name: "Young"))
      end
    end

    describe "patch" do
      before(:each) do
        @tom = User.create(first_name: "Tom", last_name: "Petty", email: "heartbreakers101@hotmail.com", username: "breakdown", password: "freefallin")
        @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
        @tigers = Team.create(name: "Tigers")
        @bob.teams << @tigers
      end

      it "changes the team's name and redirects to /:slug" do
        post "/login", {username: "nightmoves", password: "mainstreet"}
        patch "/nightmoves/teams/1", {
          name: "Lions"
        }

        expect(Team.find(1).name).to eq("Lions")
        expect(last_response.status).to eq(302)
        follow_redirect!

        expect(last_request.env["PATH_INFO"]).to eq("/nightmoves")
      end
    end
  end

  describe "/:slug/teams/:team_id/edit" do
    before(:each) do
      @tom = User.create(first_name: "Tom", last_name: "Petty", email: "heartbreakers101@hotmail.com", username: "breakdown", password: "freefallin")
      @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
      @tigers = Team.create(name: "Tigers")
      @bob.teams << @tigers
    end

    it "displays a form for changing the team" do
      post "/login", {username: "nightmoves", password: "mainstreet"}
      get "/#{@bob.slug}/teams/#{@tigers.id}/edit"

      expect(last_response.body).to include("Edit Team:")
    end
  end

  describe "/:slug/teams/:team_id/delete" do
    before(:each) do
      @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
      @tigers = Team.create(name: "Tigers")
      @bob.teams << @tigers
      post "/login", {username: "nightmoves", password: "mainstreet"}
      follow_redirect!
    end

    it "deletes the team and redirects to /:slug" do
      team_count = Team.all.size
      
      delete '/nightmoves/teams/1/delete'

      binding.pry

      expect(Team.all.size).to eq(team_count - 1)
      expect(last_response.status).to eq(302)
      follow_redirect!

      expect(last_request.env["PATH_INFO"]).to eq("/nightmoves")
    end
  end
end