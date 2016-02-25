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

# ApiKey
api1 = ApiKey.create(key: "83f8f2cebf797ef2a8594fc6f081e61a4eef892e", appName: "Testapplikation", appURL: "http://oklar.se", authentication_id: a2.id) 

# Position
po1 = Position.create(latitude: 56.66157, longitude: 16.36163)
po2 = Position.create(latitude: 57.66157, longitude: 11.36163)
po3 = Position.create(latitude: 58.66157, longitude: 12.36163)
po4 = Position.create(latitude: 59.66157, longitude: 13.36163)
po5 = Position.create(latitude: 60.66157, longitude: 14.36163)

# Creator
c1 = Creator.create(firstName: "Chris", lastName: "Wideman")
c2 = Creator.create(firstName: "Mark", lastName: "Stone")
c3 = Creator.create(firstName: "Erik", lastName: "Karlsson")
c4 = Creator.create(firstName: "Dion", lastName: "Phaneuf")
c5 = Creator.create(firstName: "Bobby", lastName: "Ryan")

# Pizzerium
pi1 = Pizzerium.create(name: "Pizzeria Ottawa", position_id: po1.id, creator_id: c1.id)
pi2 = Pizzerium.create(name: "Pizzeria Toronto", position_id: po2.id, creator_id: c2.id)
pi3 = Pizzerium.create(name: "Pizzeria Montreal", position_id: po3.id, creator_id: c3.id)
pi4 = Pizzerium.create(name: "Pizzeria Edmonton", position_id: po4.id, creator_id: c4.id)
pi5 = Pizzerium.create(name: "Pizzeria Calgary", position_id: po5.id, creator_id: c5.id)

# Menu
m1 = Menu.create(name: "Salladsmeny", pizzeria_id: pi1.id)
m2 = Menu.create(name: "Pizzameny", pizzeria_id: pi1.id)
m3 = Menu.create(name: "Gyrosmeny", pizzeria_id: pi1.id)
m4 = Menu.create(name: "Kebabmeny", pizzeria_id: pi2.id)
m5 = Menu.create(name: "I pitabröd", pizzeria_id: pi3.id)
m6 = Menu.create(name: "Vegetarisk meny", pizzeria_id: pi4.id)
m7 = Menu.create(name: "Pastameny", pizzeria_id: pi5.id)

# Dish
d1 = Dish.create(name: "Kebabpizza", ingredients: "Tomatsås, ost, lök, champinjoner, kebab, sås", price: 80, menu_id: m1.id)
d2 = Dish.create(name: "Gyrospizza", ingredients: "Tomatsås", price: 90, menu_id: m1.id)
d3 = Dish.create(name: "Kycklingsallad", ingredients: "ost", price: 100, menu_id: m1.id)
d4 = Dish.create(name: "Kebabpizza1", ingredients: "lök", price: 10, menu_id: m1.id)
d5 = Dish.create(name: "Kebabpizza2", ingredients: "champinjoner", price: 20, menu_id: m2.id)
d6 = Dish.create(name: "Kebabpizza3", ingredients: "kebab", price: 30, menu_id: m3.id)
d7 = Dish.create(name: "Kebabpizza44", ingredients: "sås", price: 40, menu_id: m4.id)
d8 = Dish.create(name: "Kebabpizza5", ingredients: "Tomatsås, ost", price: 50, menu_id: m5.id)
d9 = Dish.create(name: "Kebabpizza6", ingredients: "Tomatsås, ost, lök", price: 60, menu_id: m6.id)
d9 = Dish.create(name: "Kebabpizza7", ingredients: "Tomatsås, ost, lök, champinjoner", price: 70, menu_id: m7.id)

# Tag
t1 = Tag.create(name: "Kebab")
t2 = Tag.create(name: "Gyros")
t3 = Tag.create(name: "Sallad")
t4 = Tag.create(name: "Pommes")
t5 = Tag.create(name: "Pasta")
t6 = Tag.create(name: "Kyckling")


# PizzeriaTag
pt1 = PizzeriaTag.create(pizzeria_id: pi1.id, tag_id: t1.id)
pt2 = PizzeriaTag.create(pizzeria_id: pi2.id, tag_id: t2.id)
pt3 = PizzeriaTag.create(pizzeria_id: pi3.id, tag_id: t3.id)
pt4 = PizzeriaTag.create(pizzeria_id: pi4.id, tag_id: t4.id)
pt5 = PizzeriaTag.create(pizzeria_id: pi5.id, tag_id: t5.id)
pt6 = PizzeriaTag.create(pizzeria_id: pi1.id, tag_id: t6.id)

