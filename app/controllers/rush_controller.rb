class RushController < ApplicationController
  def index
    @events =\
      [{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'RHIT_triangle',
        author_name: 'RHIT Triangle',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: '3 days till MAZE! #MAZEWeek'
      },{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'RHIT_triangle',
        author_name: 'RHIT Triangle',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: '3 days till MAZE! #MAZEWeek'
      },{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'RHIT_triangle',
        author_name: 'RHIT Triangle',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: '3 days till MAZE! #MAZEWeek'
      },{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'RHIT_triangle',
        author_name: 'RHIT Triangle',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: '3 days till MAZE! #MAZEWeek'
      },{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'RHIT_triangle',
        author_name: 'RHIT Triangle',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: '3 days till MAZE! #MAZEWeek'
      }]
      @questions_and_answers = [
        {'question': "Who's your favorite Disney character?", 'answer': Faker::Lorem.paragraph },
        {'question': "Do you like ice cream?", 'answer': Faker::Lorem.paragraph },
        {'question': "Do you like toads?", 'answer': Faker::Lorem.paragraph },
        {'question': "Would you describe yourself as easy to talk to, fun to hang out with?", 'answer': Faker::Lorem.paragraph },
        {'question': "Are you a smelly CS?", 'answer': Faker::Lorem.paragraph },
      ]
  end
end
