# Triangle Fraternity - Rose Hulman [![Build Status](https://travis-ci.org/schepedw/rhit_triangle.svg)](https://travis-ci.org/schepedw/rhit_triangle)

## Updating the site

### Via the Site
Projects and officer positions can be edited by current officers
(both alumni and active) as well as by designated admins. Those with
the correct permissions need only to log in to see the available
actions.

### Via Code
Inevitably, the code will need to be updated. Please follow these
steps:

0.  Get your development environment up and running. [This guide](https://gorails.com/setup/ubuntu/14.10) will help you. It's probably not perfect, feel free to reach out with questions.
1.  Run the specs. I'll only take pull requests with passing tests, and
it's great to know that you have a clean slate: `bundle && bundle
exec rake`
2.  Test your change `bundle && bundle
exec rake`
3.  Update the README if needed to reflect your change / addition
4.  With all specs passing push your changes back to your fork
5.  Send me a pull request.

#### Deploying
Deployment is managed by
[capistrano](https://github.com/capistrano/rails). It's relatively
straightforward, but there are pieces I've intentionally left out -
3rd party account credentials and the like. For the time being, I'll be
managing deployments.

## Services
The site is supported by various services to
monitor activity. The logins are what you'd expect.

### Mixpanel
[Mixpanel](https://mixpanel.com/) uses Javascript to track user actions
on the site. Right now it is set to simply track page views.

### Errbit
When a user encounters an error,
[Errbit](https://github.com/errbit/errbit) will collect collect
it. These errors are aggregated and can be inspected at
http://rose-triangle.com:8081/.

