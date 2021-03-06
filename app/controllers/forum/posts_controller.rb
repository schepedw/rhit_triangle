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
      @post = Forum::Post.find_by!(post_params.except(:content, :depth))
      @post.update(content: post_params[:content])
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.message }, status: :not_acceptable
    end

    def destroy
      @post = Forum::Post.find(params[:id])
      if @post.author_id != current_member.id
        render json: { errors: 'not allowed' }, status: :forbidden
      else
        @post.destroy!
      end
    end

    private

    def verify_visibility
      render :nothing, status: 403 and return unless channel.visible_to?(current_member)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "We're sorry, something went wrong with saving your post"
      render 'error', status: 404
      flash.delete(:alert)
      # TODO: notify error watchers
    end

    def channel
      @channel ||= Forum::Channel.find(params[:channel_id])
    end

    def post_params
      params.permit(:content, :channel_id, :parent_id).merge(
        author_id: current_member.id,
        depth: depth,
        post_id: params[:id]
      )
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
