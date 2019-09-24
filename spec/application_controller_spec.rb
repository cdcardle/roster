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

describe '/signup' do
  it "get should display signup page" do
    get '/signup'

    expect(last_response).to be_ok
    expect(last_response.body).to include("Create an account to get started!")
  end

  it "post should create user after form submit and redirect to /:slug" do
    post '/signup', {
      first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet"
    }

    expect(User.find_by(username: "nightmoves")).to be_truthy
    expect(last_response.status).to eq(302)
    expect(last_response.header['Location']).to eq("http://example.org/nightmoves")
  end
end

describe '/login' do
  it "get should display login page" do
    get '/login'

    expect(last_response).to be_ok
    expect(last_response.body).to include("Log in to view your teams!")
  end

  it "post should set session[:user_id] and redirect to /:slug" do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    post '/login', {
      username: "nightmoves", password: "mainstreet"
    }

    expect(session[:user_id]).to eq(@bob.id)
    expect(last_response.status).to eq(302)
    expect(last_response.header['Location']).to eq("http://example.org/nightmoves")
  end
end

describe '/logout' do
  it "clears the session and redirects to /" do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    post '/login', {
      username: "nightmoves", password: "mainstreet"
    }

    get '/logout'
    
    expect(session[:user_id]).to eq(nil)
  end
end