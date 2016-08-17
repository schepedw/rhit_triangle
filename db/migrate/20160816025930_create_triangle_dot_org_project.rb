class CreateTriangleDotOrgProject < ActiveRecord::Migration
  def change
    Project.create({
      title: 'Reserve rose-triangle.org',
      description: "The cheapest domain available was rose-triangle.com, so that's what was used to get the website public. However, rose-triangle.org is truer to the intent of the website. The requested funding will reserve the domain for 2 years",
      project_status: ProjectStatus.find_or_create_by(status: 'Unstarted'),
      price: 27.98 })
  end
end
