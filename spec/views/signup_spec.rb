require 'spec_helper'

describe 'signup view page' do
  before do
    visit '/signup'
  end

  it "displays a form for signing up" do
    expect(page.body).to include("Create an account to get started!", "Email:", "Username:", "First Name:", "Last Name:", "Password:")
  end
end