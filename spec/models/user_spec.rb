require 'spec_helper'

describe "User" do
  before do
    @user = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
  end

  it 'has a secure password' do
    expect(@user.authenticate("agaisntthewind")).to eq(false)
    expect(@user.authenticate("mainstreet")).to eq(@user)
  end
end