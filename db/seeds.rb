# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require "nokogiri"

puts "Destroying all museums..."
Museum.destroy_all
puts "All museums destroyed"

puts "Scraping museum names"
museum_names_url = "https://www.timeout.com/london/attractions/top-london-museums"
museum_names_doc = Nokogiri::HTML(URI.open(museum_names_url).read)

museum_names = []

museum_names_doc.search("._h3_cuogz_1").each do |element|
  museum_names << element.children[1].text[1..-1]
end

puts "Museum names scraped"
puts "Getting museum urls"

museum_urls = []

museum_names_doc.search("._a_12eii_1").each do |element|
  museum_urls << element["href"]
end

puts "Museum urls scraped"

puts "Scraping museum postcodes"
museum_postcodes = []

museum_urls.each do |url|
  museum_postcode_doc = Nokogiri::HTML(URI.open(url).read)
  museum_postcodes << museum_postcode_doc.at_css("._list_1fhdc_5:first-of-type dd:last-of-type").text
end

puts "Museum postcodes scraped"

puts "Creating museums"
museum_names.each_with_index do |museum_name, index|
  Museum.create(name: museum_name, postcode: museum_postcodes[index])
  puts "#{index + 1} - #{museum_name} created"
end

puts "All museums have been created"
