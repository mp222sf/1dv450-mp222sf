# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Authentication
a1 = Authentication.create(username: "admin", email: "admin@admin.com", password: "password", password_confirmation: "password", rights: 1)
a2 = Authentication.create(username: "user1", email: "user1@user1.com", password: "userone", password_confirmation: "userone", rights: 2)

# Position
p1 = Position.create(latitude: 56.66157, longitude: 16.36163)

# Creator
c1 = Creator.create(firstName: "Mattias", lastName: "Pavic")

# Pizzerium
p1 = Pizzerium.create(name: "Pizzeria Victoria", position_id: p1.id, creator_id: c1.id)

# Menu
m1 = Menu.create(name: "Pizzameny", pizzeria_id: p1.id)

# Dish
d1 = Dish.create(name: "Kebabpizza", ingredients: "Tomatsås, ost, lök, champinjoner, kebab, sås", price: 80, menu_id: m1.id)

# Tag
t1 = Tag.create(name: "Kebab")
t2 = Tag.create(name: "Gyros")

# PizzeriaTag
pt1 = PizzeriaTag.create(pizzeria_id: p1.id, tag_id: t1.id)
pt2 = PizzeriaTag.create(pizzeria_id: p1.id, tag_id: t2.id)

