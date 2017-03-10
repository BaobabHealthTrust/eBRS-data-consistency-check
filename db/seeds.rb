# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user =  User.create(username: 'admin', password_hash: "password",  first_name: "EDRS",
        last_name: "Administrator", role: "System Administrator", email: "admin@baobabhealth.org")
            
puts "User created succesfully!"
