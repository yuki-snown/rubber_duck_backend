# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach('db/seeds/duck.csv', headers: true) do |row|
  Word.create(
    :key => row['key'],
    :rank => row['rank'],
    :pattern => row['pattern'],
    :message => row['message']
  )
end