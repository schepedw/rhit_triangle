class ForumChannelsController < ApplicationController
  def index
    #solution to n + 1 problem, using ActiveRecord: http://guides.rubyonrails.org/v2.3.11/active_record_querying.html#eager-loading-associations#nested-associations-hash
    owner = Member.first
    @channels = 20.times.map do |_|
      OpenStruct.new(subject: Faker::Lorem.word,
                     description: Faker::Lorem.sentence,
                     owner: owner,
                    ) #be aware of n+1 here, when this is more realistic
    end
    @posts = 40.times.map do |_|
      OpenStruct.new(content: Random.rand > 0.5 ? Faker::Lorem.sentence : Faker::Lorem.paragraph,
                     author_name: owner.full_name,
                     created_at: Date.today - 3.days,
                     replies: (Random.rand * 5).to_i.times.map {
                       OpenStruct.new(
                         content: Random.rand > 0.5 ? Faker::Lorem.sentence : Faker::Lorem.paragraph,
                         author_name: owner.full_name,
                         created_at: Date.today - 2.days,
                         replies: (Random.rand * 5).to_i.times.map {
                           OpenStruct.new(
                             content: Random.rand > 0.5 ? Faker::Lorem.sentence : Faker::Lorem.paragraph,
                             author_name: owner.full_name,
                             created_at: Date.today - 1.day,

                           )})})
    end
  end
end
