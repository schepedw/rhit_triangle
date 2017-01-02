Given(/^there are active officers$/) do
  @roles = ['President', 'Secretary', 'Steward', 'Activities Director',
            'Vice President', 'House Manager', 'Chapter Advisor', 'Treasurer']
  @officers = @roles.map do |role|
    create(:member).tap { |member| member.add_role(role, 'active') }
  end
end

Then(/^I will be able to see details for all of the officers$/) do
  @roles.each do |role|
    expect(page).to have_content(role)
  end

  @officers.each do |officer|
    expect(page).to have_content(officer.full_name.upcase)
    expect(page).to have_content(officer.email)
    expect(page).to have_content(officer.bio) if officer.bio.present?
  end
end

Given(/^there are alumni officers$/) do
  @roles = ['President', 'Vice President', 'Treasurer', 'Secretary', 'Alumni Representative']
  @officers = @roles.map do |role|
    create(:member, bio: Faker::Lorem.paragraph).tap { |member| member.add_role(role, 'alumni') }
  end
end
