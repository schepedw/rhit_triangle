unstarted = ProjectStatus.find_or_create_by(status: 'Unstarted')

Project.create([
  { title: 'Replace Carpet in the Hallways',
    description: "The existing carpet has been in place since 2005. We are seeking funds to tear out our current carpet in the hallways and replace them with new carpet squares. This will allow easier repair in the future without having to rip out the entire floor.",
    project_status: unstarted,
    price: 7000,
    pictures: []
}

])
