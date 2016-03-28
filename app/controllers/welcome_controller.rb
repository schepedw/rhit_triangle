class WelcomeController < ApplicationController
  def index
    @tweets =\
      [{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'RHIT_triangle',
        author_name: 'RHIT Triangle',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: '3 days till MAZE! #MAZEWeek'
      },{
        author_handle: 'tom_the_bomb',
        author_name: 'hi my names Thomas',
        retweets: 15,
        favorites: 30,
        created_at: Date.yesterday,
        content: 'hey @ato, please #suckadick #frat'
      }]
      @officers = AppConfig.officers
  end
end
