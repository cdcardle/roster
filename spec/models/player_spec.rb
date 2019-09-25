require 'spec_helper'

describe "Player" do
  it "has a first name" do
    valid_player = Player.new(first_name: "Billy", last_name: "Joel")
    invalid_player = Player.new(first_name: "", last_name: "Joel")

    expect(valid_player.save).to be(true)
    expect(invalid_player.save).to be(false)
  end

  it "has a last name" do
    valid_player = Player.new(first_name: "Billy", last_name: "Joel")
    invalid_player = Player.new(first_name: "Billy", last_name: "")

    expect(valid_player.save).to be(true)
    expect(invalid_player.save).to be(false)
  end
end