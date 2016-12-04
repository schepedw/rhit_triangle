Given(/^I am on the home page$/) do
  visit '/'
end

When(/^I click '(.*)' in the nav bar$/) do |target|
  within('.nav.nav-lower') { click_link target }
end

Then(/^I will be directed home$/) do
  expect(page.current_path).to eq '/'
end

Then(/^I will be directed to the (.*?)[ page]*$/) do |destination|
  path = destination.downcase.gsub(' ', '_')
  expect(page.current_path).to eq "/#{path}"
end
