# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_text = File.read('db/data/data.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  photo_name = row["Фото"]
  price = row["Цена"]
  cat_name = row["Категория"]
  category = Category.find_by_name cat_name
  desc = row["Описание"]
  name = row["Имя"]
  phone = row["Телефон"]

  Offer.create!(:name => name,
                :price => price.to_i,
                :desc => desc,
                :phone => phone,
                :category => category,
                :image => File.new("#{Rails.root}/db/data/images/#{photo_name.rjust(3, padstr='0')}.png"),
  )

  p row.to_hash
end
