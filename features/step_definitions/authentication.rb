Given(/^I am not signed in$/) do
  visit '/members/sign_out'
end

Given(/^I am signed in$/) do
  @member = create(:member)
  login_as(@member, scope: :member)
end

Given(/^I am on the members (.*?)[page]*$/) do |current_page|
  visit("/members/#{current_page.strip.downcase.gsub(' ', '_')}")
end

Given(/^I have an account$/) do
  @member = create(:member)
end

When(/^I enter the proper credentials$/) do
  fill_in :member_email, with: @member.email
  fill_in :member_first_name, with: @member.first_name
  fill_in :member_middle_name, with: @member.middle_name
  fill_in :member_last_name, with: @member.last_name
  fill_in :member_initiation_year, with: @member.initiation_year
  click_button 'Log in'
end

When(/^I fill in the account fields with valid information$/) do
  @member = build(:member,
                  graduation_year: 1995,
                  hometown: Faker::Address.city,
                  phone_number: Faker::PhoneNumber.phone_number,
                  bio: Faker::Lorem.paragraph
                 )
  fill_in :member_email, with: @member.email
  fill_in :member_first_name, with: @member.first_name
  fill_in :member_middle_name, with: @member.middle_name
  fill_in :member_last_name, with: @member.last_name
  fill_in :member_initiation_year, with: @member.initiation_year
  fill_in :member_graduation_year, with: @member.graduation_year
  fill_in :member_hometown, with: @member.hometown
  fill_in :member_phone_number, with: @member.phone_number
  fill_in :member_bio, with: @member.bio

  click_button 'Sign up'
end

When(/^I enter improper credentials$/) do
  fill_in :member_email, with: 'wrong'
  fill_in :member_first_name, with: 'nah'
  fill_in :member_middle_name, with: 'nope'
  fill_in :member_last_name, with: 'meh'
  fill_in :member_initiation_year, with: @member.initiation_year - 10
  click_button 'Log in'
end

When(/^I click the sign out button$/) do
  within('.nav.nav-lower') do
    click_link @member.first_name
    click_link 'Sign Out'
  end
end

Then(/^I will be signed out$/) do
  expect(page).to have_content('SIGN IN')
end

Then(/^I will be signed in$/) do
  within('.nav.nav-lower') do
    expect(page).to have_content(@member.first_name)
  end
end

Then(/^I will not be signed in$/) do
  within('.nav.nav-lower') do
    expect(page).to_not have_content(@member.first_name)
  end
end

Then(/^I will be redirected to the members sign in page$/) do
  expect(current_path).to eql '/members/sign_in'
end

Then(/^I will be notified of that I failed to login$/) do
  error = 'Invalid Email, First name, Middle name, Last name, Initiation year,
  Graduation year, Title, Bio, Hometown, Phone number or password'
  expect(page).to have_content(error.compact)
end

Then(/^I will have created an account$/) do
  attrs = %w[email first_name middle_name last_name initiation_year graduation_year hometown bio]
  expect(@member.attributes.slice(*attrs)).to eql Member.first.attributes.slice(*attrs)
  expect(PhoneNumber.first.phone_number).to eql @member.phone_number.gsub(/[^0-9]/, '')
end
