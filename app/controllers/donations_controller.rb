class DonationsController < ApplicationController
  def index
    @projects = [
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 1832.12, total_cost: 29918.12, pictures: images ),
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 32.12, total_cost: 218.12, pictures: images),
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 182.12, total_cost: 2918.12, pictures: images),
      OpenStruct.new(title: Faker::Company.catch_phrase, description: Faker::Lorem.paragraph, capital_progress: 0.00, total_cost: 29918.12, pictures: images)
    ]
  end

  private

  def images
    ['http://www.somebodymarketing.com/wp-content/uploads/freshizer/fa5fe0d62254e20aeabfb67ef6c232ac_BlogStockPhotoChoices-1156-577-c@2x.jpg',
     'http://www.somebodymarketing.com/wp-content/uploads/2013/05/Stock-Dock-House-1024x576.jpg',
     'http://www.somebodymarketing.com/wp-content/uploads/2013/05/Smoking.jpg',
     'http://www.somebodymarketing.com/wp-content/uploads/2013/05/Cute-Puppy.jpg',
     'http://www.somebodymarketing.com/wp-content/uploads/2013/05/Illustration.jpg',
     'https://bootstrapbay.com/blog/wp-content/uploads/2014/05/SLR-camera1.jpg'
    ].sample(3)

  end
end
