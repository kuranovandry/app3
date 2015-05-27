# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Movie.find_each do |movie|
  time = Time.current
  10.times{|i| movie.daily_statistics.create(sum: rand(1000..23000), date: time.ago(i.days)) }
end
