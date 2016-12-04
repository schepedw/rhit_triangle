Given(/^I am signed in$/) do
  member = create(:member)
  login_as(member, scope: :member)
end
