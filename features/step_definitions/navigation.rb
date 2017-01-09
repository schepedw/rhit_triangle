Given(/^I have notifications$/) do
  @notification = create(:notification, recipient_id: @member.id)
end

Given(/^I am on the home page$/) do
  visit '/'
end

When(/^I click '(.*)' in the nav bar$/) do |target|
  within('.nav.nav-lower') { click_link target }
end

Then(/^I will be directed home$/) do
  expect(current_path).to eq '/'
end

Then(/^I will be directed to the (.*?)[ page]*$/) do |destination|
  path = destination.downcase.gsub(' ', '_')
  expect(current_path).to eq "/#{path}"
end

Then(/^I will be able to see my notifications$/) do
  find('.notification-icon').click
  expect(page).to have_content(@notification.to_s)
end
