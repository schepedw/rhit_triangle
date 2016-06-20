class TweetsController < ApplicationController
  def index
    render json: TweetPresenter.new(*TwitterProxy.user_timeline[0..4])
  end
end
