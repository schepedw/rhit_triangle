class DonationsController < ApplicationController
  def index
    @projects = [
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 1832.12, total_cost: 29918.12),
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 32.12, total_cost: 218.12),
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 182.12, total_cost: 2918.12),
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 0.00, total_cost: 29918.12)
    ]
  end
end
