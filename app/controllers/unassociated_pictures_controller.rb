class UnassociatedPicturesController < ApplicationController
  before_action :set_admin_flag, :authorize
  include UnassociatedPicturesHelper

  def create
    new_pictures = add_pictures_from_io(params[:files]).map{ |p| p.gsub(File.join(Rails.root, 'public'), '')}
    render json: {
      newestPicture: new_pictures.last,
      newPictures: new_pictures.map { |picture| render_to_string('unassociated_pictures/_show', locals: {picture: picture, resource_type: params[:resource_type]}) },
      resourceType: params[:resource_type]
    }
  end

  private

  def authorize
    render nothing: true, status: 403 unless @admin_flag || @resource == current_user
  end
end
