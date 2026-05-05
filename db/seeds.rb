# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Resetting employees..."
Employee.delete_all

puts "Seeding employees..."

first_names = File.readlines(Rails.root.join('db/seeds/first_names.txt')).map(&:strip)
last_names  = File.readlines(Rails.root.join('db/seeds/last_names.txt')).map(&:strip)

job_titles = [ "Engineer", "Manager", "HR", "Designer", "Analyst" ]
countries  = [ "India", "USA", "UK", "Germany", "Canada" ]
departments = [ "Tech", "HR", "Finance", "Design" ]

employees = []

10000.times do
  first = first_names.sample
  last  = last_names.sample

  employees << {
    first_name: first,
    last_name: last,
    full_name: "#{first} #{last}",
    job_title: job_titles.sample,
    country: countries.sample,
    salary: rand(30_000..200_000),
    department: departments.sample,
    date_of_joining: rand(5.years).seconds.ago.to_date,
    created_at: Time.current,
    updated_at: Time.current
  }
end

Employee.insert_all(employees)

puts "Done seeding!"
