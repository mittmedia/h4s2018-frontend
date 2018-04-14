# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
Region.delete_all
filename = Rails.root.join('db', 'To2015_Swe99TM-utf8-compact.csv')
CSV.foreach(filename, col_sep: ';', row_sep: :auto, headers: true) do |row|
  county = Region.find_or_create_by(
    parent_id: 0,
    lantmateriet_reference_id: row['lanskod'],
    name: row['lan_namn'],
    level: 0
  )
  municipality = Region.find_or_create_by(
    parent_id: county.id,
    lantmateriet_reference_id: row['kommunkod'],
    name: row['kommunnamn'],
    level: 1
  )
  city_code = row['tatortskod'][1..-1].to_i
  Region.create(
    parent_id: municipality.id,
    lantmateriet_reference_id: city_code,
    name: row['tatort'],
    level: 2
  )
end
