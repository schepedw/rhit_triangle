unstarted = ProjectStatus.find_or_create_by(status: 'Unstarted')

Project.create([
  { title: 'Replace Carpet in the Hallways',
    description: "The existing carpet has been in place since 2005. We are seeking funds to tear out our current carpet in the hallways and replace them with new carpet squares. This will allow easier repair in the future without having to rip out the entire floor.",
    project_status: unstarted,
    price: 7000 },
  { title: 'Renovate the Bathroom Stalls',
    description: 'The stalls have been the same for the past 11 years. There has been much wear and tear over the years and we would like to purchase new stalls that are sturdy and easily cleaned. This will benefit the Fraternity Brothers and visitors on a daily basis.',
    project_status: unstarted,
    price: 2264 },
  { title: 'Get Outside Security Lights',
    description: 'The House has suffered from theft over the summers in the past when it is empty.  We are looking to prevent future incidents by purchasing and installing security lights. These lights will be combined with future security upgrades to make the House safer for all the Brothers.',
    project_status: unstarted,
    price: 300 },
  { title: 'Get a New Basement Door',
    description: 'The basement door of the House is damaged. We need a replacement door for security. The door in the basement will be locked at all times to prevent intruders. The current door is inadequate and must be replaced as soon as possible.',
    project_status: unstarted,
    price: 550 },
  { title: 'Replace All the Mattresses',
    description: 'The mattresses at the House are dated. We Lysol them every quarter but Lysol can only do so much over time. We would like to replace our mattress on an ongoing basis. Every new mattress bought will go to a Brother of your choosing or we will do a lottery. Believe us when we say that your donation is very much appreciated.',
    project_status: unstarted,
    price: 1600 },
  { title: 'Replank the Deck',
    description: 'We have some wooden planks on the deck that break time to time. We are asking for small donations on an ongoing basis to do repair work. The funds will cover paint, a few planks, and nails. The Brothers of the House will put in the labor.',
    project_status: unstarted,
    price: 100 },
  { title: 'Retile the Lobby',
    description: 'Many of the House events are centered in the House lobby. There is also a lot of traffic in this area in general. As you can see, there is a lot of damage in one particular spot. We are requesting funds to retile the lobby and make it look more presentable.',
    project_status: unstarted,
    price: 0 },
])

20.times.map do |_|
  Forum::Channel.create(subject: Faker::Lorem.word, description: Faker::Lorem.sentence)
end

def random_select(model_class)
  offset = rand(model_class.count)
  model_class.offset(offset).first
end

400.times.map do |_|
  channel=  random_select(Forum::Channel)
  Forum::Post.create(content: Random.rand > 0.5 ? Faker::Lorem.sentence : Faker::Lorem.paragraph,
                     author: Member.first,
                     created_at: Date.today - [7,8,9].sample.days,
                     channel: channel,
                     depth: 0,
                     replies: (Random.rand * 5).to_i.times.map {
                       Forum::Post.create(
                         content: Random.rand > 0.5 ? Faker::Lorem.sentence : Faker::Lorem.paragraph,
                         author: Member.first,
                         created_at: Date.today - [4,5,6].sample.days,
                         channel: channel,
                         depth: 1,
                         replies: (Random.rand * 5).to_i.times.map {
                           Forum::Post.create(
                             content: Random.rand > 0.5 ? Faker::Lorem.sentence : Faker::Lorem.paragraph,
                             author: Member.first,
                             channel: channel,
                             created_at: Date.today - [1,2,3].sample.days,
                             depth: 2,
                           )})})
end
