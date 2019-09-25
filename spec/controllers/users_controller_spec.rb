require "spec_helper"

@bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")

describe "/:slug" do
  it "redirects to '/' if not logged in" do
    get '/nightmoves'
    expect(last_response.header['Location']).to eq("http://example.org/")
  end
end