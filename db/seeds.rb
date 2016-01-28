# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Authentication.destroy_all
a1 = Authentication.create(username: "mp222sf", email: "mp222sf@student.lnu.se", password: "hejhej123", password_confirmation: "hejhej123", rights: 1)
