class DonationsController < ApplicationController
  def index
    @projects = Project.where.not(price: 0)
  end

  def create
  end
end
