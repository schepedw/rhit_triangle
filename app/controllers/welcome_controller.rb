class WelcomeController < ApplicationController
  def index
    @tweets =\
      [{
        author_thumbnail: nil, #not sure what to do with this one
        author_handle: 'pirates_water_cooler',
        author_name: 'ur_mom',
        retweets: 3,
        favorites: 5,
        created_at: Date.today,
        content: 'lol jk chek out this shit tho'
      },{
        author_handle: 'tom_the_bomb',
        author_name: 'hi my names Thomas',
        retweets: 15,
        favorites: 30,
        created_at: Date.yesterday,
        content: 'tweet twoot twaat twiit twuut'
      }]
      @officers = [{
        name: 'Kris France',
        title: 'President',
        email: 'francekm@rose-hulman.edu',
        phone: '(513) 292-2706'
      },{
        name: 'Seth Dow',
        title: 'Vice President',
        email: 'dowsr@rose-hulman.edu',
        phone: '(513) 292-2706'
      },{
        name: 'Kris France',
        title: 'President',
        email: 'francekm@rose-hulman.edu',
        phone: '(513) 292-2706'
      },{
        name: 'Kris France',
        title: 'President',
        email: 'francekm@rose-hulman.edu',
        phone: '(513) 292-2706'
      },{
        name: 'Kris France',
        title: 'President',
        email: 'francekm@rose-hulman.edu',
        phone: '(513) 292-2706'
      },{
        name: 'Kris France',
        title: 'President',
        email: 'francekm@rose-hulman.edu',
        phone: '(513) 292-2706'
      },{
        name: 'Kris France',
        title: 'President',
        email: 'francekm@rose-hulman.edu',
        phone: '(513) 292-2706'
      }
      ]
  end
end
