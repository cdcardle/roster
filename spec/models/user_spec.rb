require 'spec_helper'

describe "User" do
  before do
    @bob = User.create(first_name: "Bob", last_name: "Seger", email: "silverbullet1945@hotmail.com", username: "night moves", password: "mainstreet")
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
      @joe.username = "night moves"

      expect(@joe.save).to eq(false)
    end

    it "is at least 8 characters long" do
      @joe.username = "joe"
      @bob.username = "bobsusername"

      expect(@joe.save).to eq(false)
      expect(@bob.save).to eq(true)
    end
  end

  describe "first name" do
    it 'is not blank' do
      @joe.first_name = ''
      @bob.first_name = 'Axl'

      expect(@joe.save).to eq(false)
      expect(@bob.save).to eq(true)
    end
  end

  describe "last name" do
    it 'is not blank' do
      @joe.last_name = ''
      @bob.last_name = 'Rose'

      expect(@joe.save).to eq(false)
      expect(@bob.save).to eq(true)
    end
  end

  describe "slug" do
    it 'slugs the username' do
      expect(@bob.slug).to eq("night-moves")
    end
  end

  describe "find_by_slug" do
    it 'can find a user based on the slug' do
      slug = @bob.slug
      expect(User.find_by_slug(slug).username).to eq("night moves")
    end
  end
end