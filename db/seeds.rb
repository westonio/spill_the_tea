Customer.destroy_all
Tea.destroy_all
Subscription.destroy_all

Customer.create(name: "Mimi Imfurst", email: "jaimee@carroll.test", address: "3971 Karissa Mountains, North Charita, MT 67591-7763")
Customer.create(name: "Roxxxy Andrews", email: "lou_schulist@baumbach.test", address: "Apt. 966 432 Michal Harbor, Hansenfort, AZ 90846-7109")
Customer.create(name: "Mercedes Iman Diamond", email: "milan_collier@roberts.test", address: "Suite 562 62545 Melania Mills, Turcotteburgh, ME 15020")

Tea.create(name: "Kangra", description: "Herbal", brew_temp: "180-195 Degrees", brew_time: "1-2 minutes")

Tea.create(name: "Shui Jin Gui", description: "White", brew_temp: "180-185 Degrees", brew_time: "2-3 minutes")
Tea.create(name: "Boldo", description: "Oolong", brew_temp: "212 Degrees", brew_time: "1-2 minutes")
Tea.create(name: "Biluochun", description: "Black", brew_temp: "195-212 Degrees", brew_time: "1-2 minutes")
Tea.create(name: "Gyokuro", description: "Herbal", brew_temp: "180-195 Degrees", brew_time: "1-2 minutes")
Tea.create(name: "Fujian New Craft", description: "Oolong", brew_temp: "212 Degrees", brew_time: "1-2 minutes")
Tea.create( name: "Ruan Zhi", description: "Herbal", brew_temp: "180-195 Degrees", brew_time: "1-2 minutes")
Tea.create(name: "Bael Fruit", description: "Black", brew_temp: "180-195 Degrees", brew_time: "3 minutes")
Tea.create(name: "Huangjin Gui", description: "White", brew_temp: "180-195 Degrees", brew_time: "1 minutes")
Tea.create(name: "Fujian New Craft", description: "Oolong", brew_temp: "200-210 Degrees", brew_time: "4 minutes")

Subscription.create(title: "Sissy that walk.", price: 60.75, frequency: 3, customer_id: 1, tea_id: 1)
Subscription.create(title: "Put the bass in your walk.", price: 57.79, frequency: 2, customer_id: 1, tea_id: 2)
Subscription.create(title: "She done already done had herses.", price: 51.89, frequency: 0, customer_id: 1, tea_id:3, status: 1)