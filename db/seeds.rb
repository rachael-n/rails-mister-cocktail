# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
# require 'faker'
# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# drink_data = JSON.parse(open(url).read)

# faker_ingredients = []
# drink_data['drinks'].each do |item|
#   faker_ingredients << item['strIngredient1']
# end

# puts 'Clearing out the cocktail list.'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

# puts 'Making a fresh batch.'

# 15.times do
#   faker_cocktail = Cocktail.new(name: Faker::Dessert.unique.flavor)
#   faker_cocktail.save

#   3.times do
#     faker_ingredient = Ingredient.new(name: faker_ingredients.sample)
#     faker_ingredient.save

#     faker_dose = Dose.new(
#       description: Faker::Food.measurement,
#       ingredient_id: faker_ingredient.id,
#       cocktail_id: faker_cocktail.id
#     )
#     faker_dose.save
#   end
#   faker_cocktail.save!
# end

("a".."z").each do |letter|
url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
puts "getting #{letter}"
response = open(url).read
cocktail_repo = JSON.parse(response)
cocktails = cocktail_repo["drinks"]

next if cocktails.nil?

cocktails.sample(5).each do |cocktail|
  new_cocktail = Cocktail.create(name: cocktail['strDrink'])
  i = 1
  loop do
    ingredient_name = cocktail["strIngredient#{i}"]
    ingredient_description = cocktail["strMeasure#{i}"]
    break if ingredient_name == nil
    new_ingredient = Ingredient.find_or_create_by(name: ingredient_name)
    Dose.create(cocktail: new_cocktail, ingredient: new_ingredient, description: ingredient_description)
    i += 1
    end
  end
end
