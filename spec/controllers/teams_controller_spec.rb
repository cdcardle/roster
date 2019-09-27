require "spec_helper"

describe '/:slug/teams/:team_id' do
  before(:each) do
    @tom = User.create(first_name: "Tom", last_name: "Petty", email: "heartbreakers101@hotmail.com", username: "breakdown", password: "freefallin")
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @tigers = Team.create(name: "Tigers")
    @bob.teams << @tigers
  end

  it "get should display team info if logged in as that team's coach" do
    post '/login', {username: "nightmoves", password: "mainstreet"}

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
    post '/login', {username: "breakdown", password: "freefallin"}

    get "/#{@bob.slug}/teams/#{@tigers.id}"

    expect(last_response.status).to eq(302)
    follow_redirect!
    expect(last_request.env["PATH_INFO"]).to eq("/")
  end
end