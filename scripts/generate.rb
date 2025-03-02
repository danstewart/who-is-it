#!/usr/bin/env ruby

require "faker"
require "open-uri"

puts "Generating data..."

base_url = "https://randomuser.me/api/portraits"
genders = ["men", "women"]

people = []

# Download all images and assign them a fake name
genders.each do |gender|
  (1..99).each do |i|
    image_url = "#{base_url}/#{gender}/#{i}.jpg"

    # Download image to disk and save with uuid
    image_id = SecureRandom.uuid
    image_path = "./site/images/people/#{image_id}.jpg"
    download = URI.open(image_url).read
    open(image_path, "wb") do |f|
      f.write(download)
    end

    name = gender == "men" ? Faker::Name.male_first_name : Faker::Name.female_first_name

    people << {
      name: name,
      image_id: image_id,
    }
  end
end

# Save file to disk
File.open("./site/data/people.json", "w") do |f|
  f.write(JSON.pretty_generate(people))
end

puts "Data generated successfully!"
puts "Data saved to ./site/data/people.json"
