module Forum
  class PostsController < ApplicationController
    before_action :authenticate_member!, :verify_visibility

    def create
      @post = Forum::Post.create!(post_params)
      @parent_id = parent.try(:id)
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.message }, status: :not_acceptable
    end

    def update

    end

    def destroy

    end

    private

    def verify_visibility
      render :nothing, status: 403 and return unless channel.visible_to?(current_member)
    end

    def channel
      @channel ||= Forum::Channel.find(params[:channel_id])
    end

    def post_params
      params.permit(:content, :channel_id, :parent_id).merge(author_id: current_member.id, depth: depth)
    end

    def parent
      return if params[:parent_id].blank?
      @parent ||= Forum::Post.find(params[:parent_id])
    end

    def depth
      parent.nil? ? 0 : parent.depth + 1
    end
  end
end
