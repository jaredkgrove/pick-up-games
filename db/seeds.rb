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

player_names = ["Jared", "Michael Jordan", "Timmy", "Steph Curry", "John", "Maya Moore", "Candace Parker", "Bethany", "Chelsea Gray", "Cool Guy", "Tom", "Bill", "Saundra", "DeeAnn", "Jimnothy", "My real name", "Trevor002", "Tuff_guy10", "Petra", "Ball hog"]

player_names.each do |name|
    player = Player.create(name:name, password:"password", email:"#{name.gsub(/\s+/, "")}@email.com")   
end

squad_names_array = ["Squad", "Team", "boys", "girls", "troop", "posse", "battalion"]
adjectives_array =["cool", "bad", "old", "awesome", "neat-o", "purple", "cheating", "over-enthusiastic"]

Player.all.each do |player|
    court = Court.all.sample  
    3.times do
        game = player.games.build({court_id: court.id, time: rand(4.days).seconds.from_now, skill_level: Game.skill_level_array.sample})
        if game.save
            game.make_admin(player)
        end
    end
    squad = player.squads.build({name: "#{adjectives_array.sample} #{squad_names_array.sample}"})
    if squad.save
        squad.make_admin(player)
    end
end

Player.all.each do |player|
    rand(2..5).times do
        game = Game.all.sample
        game.add_or_remove_player(player) if !player.is_admin_of?(game) && !game.is_in_game?(player)
        squad = Squad.all.sample
        squad.add_or_remove_player(player) if !player.is_admin_of?(squad)
    end
end


