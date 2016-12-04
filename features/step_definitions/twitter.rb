Given(/^Rose Triangle has tweeted$/) do
  user_attrs = { id: rand(5),
                 profile_image_url_https: 'https://www.foo.com',
                 name: 'Dan', screen_name: '@tall_dan' }
  @tweet = Twitter::Tweet.new(
    id: rand(5),
    user: user_attrs,
    created_at: Time.zone.now.to_s,
    text: 'testing is nifty',
    url: 'https://www.example.com/tweets/1'
  )
  allow(TwitterProxy).to receive(:user_timeline) { [@tweet] }
end

Then(/^I should see the tweets$/) do
  wait_for_ajax
  within('.tweets') do
    expect(page).to have_content(@tweet.text)
    expect(page).to have_content(@tweet.user.name)
    expect(page).to have_content(@tweet.user.screen_name)
    expect(page).to have_content(@tweet.created_at.strftime('%b %-d'))
  end
end
