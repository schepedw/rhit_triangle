module Forum
  class ChannelsController < ApplicationController
    before_action :store_location, :authenticate_member!

    def index
      @current_channel = channel_from_session || default_channel
      # TODO: add scope for public + private channels I can see
      session[:channel_id] = @current_channel.id
      @all_channels = Forum::Channel.publik.select(:subject, :channel_id)
      @posts = posts
    end

    def show
      @current_channel = Forum::Channel.find(params[:id])
      session[:channel_id] = params[:id]
      @posts = posts(@current_channel)
      respond_to do |format|
        format.js
        format.html { @all_channels = Forum::Channel.publik.select(:subject, :channel_id) }
      end
    end

    def create
      @current_channel = Forum::Channel.where('lower(subject) = ?', channel_params[:subject]).first
      @current_channel ||= Forum::Channel.create(channel_params)
      @posts = []
    end

    private

    def default_channel
      return @default_channel unless @default_channel.nil?
      channel = Forum::Post.select('count(*)', :channel_id).group(:channel_id).order(count: :desc).first
      return Forum::Channel.nil_channel unless channel
      most_active_channel = Forum::Channel.find(channel.channel_id)
      return @default_channel = most_active_channel if most_active_channel.publik?
      @default_channel = Forum::Channel.publik.order(:created_at).first
    end

    def channel_from_session
      Forum::Channel.find(session[:channel_id]) if session[:channel_id]
    end

    def posts(channel = default_channel)
      Forum::Post.includes(:author, :reactions, replies: [:author, :reactions, replies: [:author, :reactions]]).
        where(channel_id: channel.id, depth: 0).order(:created_at)
    end

    def channel_params
      params.require(:forum_channel).permit(:subject, :description, :visibility)
    end

    def store_location
      store_location_for(:member, request.path)
    end
  end
end
