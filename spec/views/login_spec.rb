require 'spec_helper'

describe 'login view page' do
  before do
    visit '/login'
  end

  it "displays a form for logging in" do
    expect(page.body).to include("Log in to view your teams!", "Username...", "Password...", "Log In!")
  end
end