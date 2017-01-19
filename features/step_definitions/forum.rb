Given(/^the forum channel has at least one post by someone else$/) do
  member = create(:member)
  @post = create(:post, author_id: member.id)
end

Given(/^there are multiple forum channels$/) do
  @channels = create_list(:channel, 3)
end

Given(/^I have written at least one post$/) do
  @post = create(:post, author_id: @member.id, channel_id: @channel.id)
end

Given(/^I have tagged a member in a post$/) do
  step 'I tag a member in a post'
end

Given(/^there is a forum channel$/) do
  @channel = create(:channel)
end

Given(/^I have liked that post$/) do
  @post = @posts.last
  @reaction = create(:reaction, post_id: @post.id, member_id: @member.id)
end

Given(/^the forum channel has at least one post$/) do
  @channel = create(:channel)
  @posts = create_list(:post, 2, channel_id: @channel.id)
end

When(/^I visit that channel$/) do
  click_link @channel.subject
  wait_for_ajax
end

When(/^I (?:visit|am on) the forum page$/) do
  visit '/forum'
  # TODO: Remove these three lines if we get db cleaning to work. @channel should be the only channel
  if current_path == '/forum'
    click_link(@channel.subject)
    wait_for_ajax
  end
end

When(/^I click a new channel$/) do
  @channel = @channels.find { |c| page.has_no_content? c.description }
  click_link(@channel.subject)
  wait_for_ajax
end

When(/^I post in the channel$/) do
  @new_post_content = Faker::Lorem.paragraph
  fill_in('content', with: @new_post_content)
  find('#content').send_keys(:enter)
  wait_for_ajax
end

When(/^I like a post$/) do
  @post = @channel.posts.last
  within("[data-reactions-for-post-id='#{@post.id}']") do
    click_link 'Like'
  end
  wait_for_ajax
end

When(/^I edit my post$/) do
  @new_post_content = Faker::Lorem.paragraph
  find(".edit-post[data-post-id='#{@post.id}']").click
  content_container = find('.edit-post-container #content')
  content_container.set(@new_post_content)
  content_container.send_keys(:enter)
  wait_for_ajax
end

When(/^I delete my post$/) do
  click_link 'Delete'
  wait_for_ajax
end

When(/^I reply to a post$/) do
  @post = @posts.first
  find(".reply-to-post[data-post-id='#{@post.id}']").click
  @new_post_content = Faker::Lorem.paragraph
  find('.new-reply #content').set(@new_post_content)
  find('.new-reply #content').send_keys(:enter)
  wait_for_ajax
end

When(/^I tag a member in a post$/) do
  @tagged_member = create(:member)
  @new_post_content = "Hello, @#{@tagged_member.reload.screen_name}!"
  fill_in('content', with: @new_post_content)
  find('#content').send_keys(:enter)
  wait_for_ajax
end

When(/^I unlike a post$/) do
  @post = @channel.posts.last
  within("[data-reactions-for-post-id='#{@post.id}']") do
    click_link 'Unlike(1)'
  end
  wait_for_ajax
end

Then(/^I will see the member count and description of that channel$/) do
  expect(page).to have_content("#{@channel.member_count} Members")
  expect(page).to have_content(@channel.description)
end

Then(/^I will see that the post has been unliked$/) do
  expect(@post.reactions).to be_empty
  within("[data-reactions-for-post-id='#{@post.id}']") do
    expect(page).to have_content('Like')
  end
end

Then(/^I will not have the ability to edit that post$/) do
  expect(page).to_not have_selector(".edit-post[data-post-id='#{@post.id}']")
end

Then(/^the post will be deleted$/) do
  expect(page).to_not have_content(@post.content)
  expect(Forum::Post.find_by_post_id(@post.id)).to be_nil
end

Then(/^I will not have the ability to delete that post$/) do
  expect(page).to_not have_selector(".delete-post[data-post-id='#{@post.id}']")
end

Then(/^I will see the posts for the channel$/) do
  @channel.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

Then(/^I will see my post in that channel's contents$/) do
  expect(find('#content').text).to be_empty
  expect(page).to have_content(@new_post_content)
end

Then(/^I will see that the post has been liked$/) do
  expect(@post.reactions).to_not be_empty
  within("[data-reactions-for-post-id='#{@post.id}']") do
    expect(page).to have_content('Unlike(1)')
  end
end

Then(/^my reply will be visible$/) do
  expect(@post.replies).to_not be_empty
  reply = @post.replies.first
  expect(reply.content).to eql(@new_post_content)
  expect(page).to have_content(@new_post_content)
end

Then(/^the change to my post will be saved$/) do
  expect(@post.reload.content).to eq @new_post_content
  expect(page).to have_content @new_post_content
end

Then(/^a notification will be created for that member$/) do
  post = Forum::Post.find_by_content(@new_post_content)
  expect(Notification.find_by(post_id: post.id, recipient_id: @tagged_member, notifier_id: @member.id)).to be_present
end

Then(/^the associated notification will be deleted$/) do
  expect(Notification.all).to be_empty
end
