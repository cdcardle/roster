require_relative "spec_helper"

def app
  ApplicationController
end

@bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
@tom = User.create(first_name: "Tom", last_name: "Petty", email: "heartbreakers101@hotmail.com", username: "breakdown", password: "freefallin")

describe '/' do  
  it "redirects to /login if not logged in" do
    get '/'
    follow_redirect!
    expect(last_response.body).to include("Log in to view your teams!")
  end

  it "redirects to /:slug if already logged in" do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    post '/login', {
      username: "nightmoves", password: "mainstreet"
    }

    get '/'
    expect(last_response.header['Location']).to eq('http://example.org/nightmoves')
  end
end
