class UnassociatedPicturesController < ApplicationController
  before_action :set_admin_flag, :authorize
  include UnassociatedPicturesHelper

  def create
    new_pictures = add_pictures_from_io(params[:files])
    new_picture_html = new_pictures.map do |picture|
      picture_path = picture.gsub(File.join(Rails.root, 'public'), '')
      render_to_string('unassociated_pictures/_show',
                       locals: { picture: picture_path, resource_type: params[:resource_type] })
    end

    render json: {
      newPictures: new_picture_html,
      resourceType: params[:resource_type]
    }
  end

  private

  def authorize
    render nothing: true, status: 403 unless @admin_flag || @resource == current_user
  end
end
