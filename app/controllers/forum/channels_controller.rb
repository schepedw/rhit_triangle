module Forum
  class ChannelsController < ApplicationController
    def index
      #solution to n + 1 problem, using ActiveRecord: http://guides.rubyonrails.org/v2.3.11/active_record_querying.html#eager-loading-associations#nested-associations-hash
      @channels = Forum::Channel.all
      @posts = Forum::Post.all #definitely want to include author here
    end
  end
end
