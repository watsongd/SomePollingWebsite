# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 0..20
  if i % 2 == 0
    Poll.create(title: i.to_s, options: {"yes": i, "no": i}, public: true, cached_total_votes: 2 * i)
  else
    Poll.create(title: i.to_s, options: {"yes": i, "no": i}, public: false, cached_total_votes: 2 * i)
  end
end
for i in 0..100
  Vote.create(ip: i.to_s, poll_id: i / 5)
end
