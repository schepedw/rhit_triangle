# TODO: rm after release of https://github.com/schepedw/rhit_triangle/pull/13
class AlumniOfficer < ActiveRecord::Base
  belongs_to :member
  default_scope { includes(:member) }
end
