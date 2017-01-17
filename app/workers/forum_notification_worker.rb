class ForumNotificationWorker
  include Sidekiq::Worker

  def perform(post_id, tagged_member_ids)
    return if tagged_member_ids.empty?
    post = Forum::Post.find(post_id)
    tagged_members = Member.find(tagged_member_ids)
    tagged_members.each do |member|
      next if member.id == post.author_id
      notification = Notification.create!(post_id: post.id, notifier_id: post.author_id, recipient_id: member.id)
      EmailNotificationWorker.perform_in(5.minutes, [notification.id])
    end
  end
end
