# spec/factories/employees.rb
FactoryBot.define do
  factory :employee do
    first_name { "Niraj" }
    last_name  { "Kumar" }
    job_title  { "Engineer" }
    country    { "India" }
    salary     { 50000 }
  end
end
