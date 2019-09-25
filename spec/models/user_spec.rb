require 'spec_helper'

describe "User" do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "nightmoves", password: "mainstreet")
    @joe = User.new(email: "joesatriani@gmail.com", first_name: "Joe", last_name: "Satriani", username: "joesatriani", password: "joespassword")
  end

  describe "password" do
    it 'is secure' do
      expect(@bob.authenticate("agaisntthewind")).to eq(false)
      expect(@bob.authenticate("mainstreet")).to eq(@bob)
    end

    it "is at least 8 characters long" do
      @joe.password = "joe"
      @bob.password = "bobspassword"

      expect(@joe.save).to eq(false)
      expect(@bob.save).to eq(true)
    end
  end

  describe "email" do
    it 'is not blank' do
      @joe.email = ''
      @bob.email = 'againstthewind@yahoo.com'

      expect(@joe.save).to eq(false)
      expect(@bob.save).to eq(true)
    end

    it 'is unique' do
      @joe.email = "silverbullet1945@hotmail.com"

      expect(@joe.save).to eq(false)
    end
  end

  describe "username" do
    it "is unique" do
      @joe.username = "nightmoves"

      expect(@joe.save).to eq(false)
    end

    it "is at least 8 characters long" do
      @joe.username = "joe"
      @bob.username = "bobsusername"

      expect(@joe.save).to eq(false)
      expect(@bob.save).to eq(true)
    end
  end
end