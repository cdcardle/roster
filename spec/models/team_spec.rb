require 'spec_helper'

describe "Team" do
  it "has a name" do
    valid_team = Team.new(name: "Tigers")
    invalid_team = Team.new(name: "")
    
    expect(valid_team.save).to be(true)
    expect(invalid_team.save).to be(false)
  end
end