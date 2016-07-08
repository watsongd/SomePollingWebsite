# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..20
  if i % 2 == 0
    Poll.create(title: i.to_s, options: {"yes": 0, "no": 0}, public: true)
  else
    Poll.create(title: i.to_s, options: {"yes": 0, "no": 0}, public: false)
  end
end
