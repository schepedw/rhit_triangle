module Forum
  class ReactionsController < ApplicationController
    before_action :authenticate_member!, :check_permissions, :check_associations

    def create
      @reaction = Forum::Reaction.create(reaction_params)
      @post = @reaction.post
    end

    def destroy
      @reaction = Forum::Reaction.find_by(reaction_params).destroy
      @post = @reaction.post
    end

    private

    def reaction_params
      { member_id: current_member.id,
        post_id: params.require(:post_id),
        reaction_id: params[:id],
        reaction_text: 'Like'
      }
    end

    def check_permissions
      unless Forum::Channel.find(params[:channel_id]).visible_to? current_member
        render nothing: true, status: :unauthorized
      end
    end

    def check_associations
      channel = Forum::Channel.includes(:posts).find(params[:channel_id])
      unless channel.posts.pluck(:post_id).include? params.require(:post_id).to_i
        render nothing: true, status: :unauthorized
      end
    end
  end
end
