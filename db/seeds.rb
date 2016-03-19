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
po1 = Position.create(address: "Bjelkegatan 11, 392 30 Kalmar")
po2 = Position.create(address: "Adelgatan 3, 393 50 Kalmar")
po3 = Position.create(address: "Ståthållaregatan 30, 392 45 Kalmar")
po4 = Position.create(address: "S:ta Gertruds gata 4, 392 53 Kalmar")
po5 = Position.create(address: "Södra Långgatan 7, 392 32 Kalmar")

# Creator
c1 = Creator.create(firstName: "The", lastName: "Admin")

# Pizzerium
pi1 = Pizzerium.create(name: "Ängö Pizzeria", position_id: po1.id, creator_id: c1.id)
pi2 = Pizzerium.create(name: "Funkabo Pizzeria", position_id: po2.id, creator_id: c1.id)
pi3 = Pizzerium.create(name: "Pizzeria Flamenco", position_id: po3.id, creator_id: c1.id)
pi4 = Pizzerium.create(name: "Restaurang Italia", position_id: po4.id, creator_id: c1.id)
pi5 = Pizzerium.create(name: "Pizzeria Viktoria", position_id: po5.id, creator_id: c1.id)

# Menu
m1 = Menu.create(name: "Salladsmeny", pizzeria_id: pi1.id)
m2 = Menu.create(name: "Pizzameny", pizzeria_id: pi4.id)
m3 = Menu.create(name: "Gyrosmeny", pizzeria_id: pi3.id)
m4 = Menu.create(name: "Kebabmeny", pizzeria_id: pi2.id)
m5 = Menu.create(name: "Pastameny", pizzeria_id: pi5.id)

# Dish
d1 = Dish.create(name: "Kebabsallad", ingredients: "", price: 65, menu_id: m1.id)
d2 = Dish.create(name: "Gyrossallad", ingredients: "", price: 65, menu_id: m1.id)
d3 = Dish.create(name: "Räksallad", ingredients: "", price: 65, menu_id: m1.id)

d4 = Dish.create(name: "Capriciosa", ingredients: "Tomatsås, ost, skinka, champinjoner", price: 65, menu_id: m2.id)
d5 = Dish.create(name: "Vesuvio", ingredients: "Tomatsås, ost, skinka", price: 65, menu_id: m2.id)
d6 = Dish.create(name: "Cleopatra", ingredients: "Tomatsås, ost, bacon, lök, räkor", price: 65, menu_id: m1.id)

d7 = Dish.create(name: "Gyrostallrik", ingredients: "", price: 65, menu_id: m3.id)
d8 = Dish.create(name: "Gyros i pita", ingredients: "", price: 65, menu_id: m3.id)
d9 = Dish.create(name: "Gyrosrulle", ingredients: "", price: 65, menu_id: m3.id)

d10 = Dish.create(name: "Kebabtallrik", ingredients: "", price: 65, menu_id: m4.id)
d11 = Dish.create(name: "Kebab i pita", ingredients: "", price: 65, menu_id: m4.id)
d12 = Dish.create(name: "Kebabrulle", ingredients: "", price: 65, menu_id: m4.id)

d13 = Dish.create(name: "Oxfilépasta", ingredients: "", price: 65, menu_id: m5.id)
d14 = Dish.create(name: "Fläskfilé i pepparsås", ingredients: "", price: 65, menu_id: m5.id)
d15 = Dish.create(name: "Spaghetti Bolognese", ingredients: "", price: 65, menu_id: m5.id)

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

