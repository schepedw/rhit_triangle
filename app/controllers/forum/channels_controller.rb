module Forum
  class ChannelsController < ApplicationController
    def index
      @current_channel = default_channel
      @all_channels = Forum::Channel.publik.select(:subject, :channel_id) #TODO: add scope for public + private channels I can see
      @posts = posts
    end

    def show
      @current_channel = Forum::Channel.find(params[:id])
      @posts = posts(@current_channel)
    end

    private

    def default_channel
      return @default_channel unless @default_channel.nil?
      channel_id = Forum::Post.select('count(*)', :channel_id).group(:channel_id).order(count: :desc).first.channel_id
      most_active_channel = Forum::Channel.find(channel_id)
      @default_channel = most_active_channel.publik? ? most_active_channel : Forum::Channel.publik.order(:created_at).first
    end

    def posts(channel = default_channel)
      #This only gets us a depth of 1 reply.. need to get to at least 2
      Forum::Post.includes(:author, replies: [:author, replies: :author]).where(channel_id: channel.id, depth: 0).order(:created_at)
    end
  end
end
