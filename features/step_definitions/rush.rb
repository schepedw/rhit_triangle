When(/^I am on the rush page$/) do
  visit '/rush'
end

Then(/^I should see frequently asked questions$/) do
  AppConfig.q_and_a.each do |a|
    expect(page).to have_content(a[:question].upcase)
  end
end

Then(/^I should see the answers to these questions$/) do
  AppConfig.q_and_a.each do |a|
    expect(page).to have_content(a[:answer])
  end
end
