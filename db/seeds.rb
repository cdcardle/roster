User.all.clear
Team.all.clear
Player.all.clear
User.destroy_all
Team.destroy_all
Player.destroy_all

joe = User.new(username: "joejackson123", first_name: "Joe", last_name: "Jackson", email: "joejackson@gmail.com", password: "joej1234")
pete = User.new(username: "petesmith123", first_name: "Pete", last_name: "Smith", email: "petesmith@microsoft.com", password: "petes1234")

joe.save
pete.save

tigers = Team.new(name: "Tigers")
cobras = Team.new(name: "Cobras")
lions = Team.new(name: "Lions")

tigers.save
cobras.save
lions.save

joe.teams << tigers
joe.teams << cobras
pete.teams << lions

tom = Player.new(first_name: "Tom", last_name: "Smith")
sam = Player.new(first_name: "Sam", last_name: "Peters")
peter = Player.new(first_name: "Peter", last_name: "Michelle")
chris = Player.new(first_name: "Chris", last_name: "Joe")
ursula = Player.new(first_name: "Ursula", last_name: "Smitherson")
jeff = Player.new(first_name: "Jeff", last_name: "Samson")
cameron = Player.new(first_name: "Cameron", last_name: "Bricks")

tom.save
sam.save
peter.save
chris.save
ursula.save
jeff.save
cameron.save

tigers.players << tom
tigers.players << sam
cobras.players << peter
cobras.players << chris
lions.players << ursula
lions.players << jeff
lions.players << cameron

joe.players << tom
joe.players << sam
joe.players << peter
joe.players << chris
pete.players << ursula
pete.players << jeff
pete.players << cameron