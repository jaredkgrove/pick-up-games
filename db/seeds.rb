# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
courts_array = [
                {name: "Jimmy's Backyard", location: "123 Street"},
                {name: "Cool Park", location: "456 Road"},
                {name: "North Commons", location: "234 Circle"},
                {name: "Minehaha Park", location: "123 Road"},
                {name: "South Commons", location: "952 Avenue"},
                {name: "East Commons", location: "051 Place"},
                {name: "West Commons", location: "680 Lane"},
                {name: "North Community Center", location: "579 Street"},
                {name: "South Community Center", location: "468 Road"},
                {name: "YMCA", location: "357 Avenue"},
                {name: "Monica's Driveway", location: "246 Lane"},
                {name: "Staples Center", location: "135 Street"},
                {name: "Target Center", location: "321 Circle"},
                {name: "Central Park", location: "432 Avenue"},
                {name: "East Community Center", location: "543 Lane"},
                {name: "Church Parking Lot", location: "654 Street"},
                {name: "North High School", location: "765 Lane"},
                {name: "South High School", location: "876 Road"},
                {name: "West Community Center", location: "987 Avenue"},
                {name: "West High", location: "098 Street"}
            ] 
courts_array.each do |court_hash|
    Court.create(location:court_hash[:location], name: court_hash[:name])
end

player_names = ["Jared", "Michael Jordan", "Timmy", "Steph Curry", "John", "Maya Moore", "Candace Parker", "Bethany", "Chelsea Gray"]

player_names.each do |name|
    player = Player.create(name:name, password:"password", email:"#{name.gsub(/\s+/, "")}@email.com")
    court = Court.all.sample    
end

Player.all.each do |player|
    court = Court.all.sample  
    player.create_game_from_hash({court_id: court.id, time: rand(10.days).seconds.from_now, skill_level: Game.skill_level_array.sample})
end

Player.all.each do |player|
    rand(1..5).times do
        game = Game.all.sample
        game.add_or_remove_player(player) if !player.is_admin_of?(game)
    end
end