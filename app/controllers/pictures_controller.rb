class PicturesController < ApplicationController
  before_action :identify_resource, :set_admin_flag, :authorize

  def create
    new_pictures = @resource.add_pictures_from_io(params[:files])
    render json: {
      newHTML: render_to_string(partial: 'index', locals:
                                { pictures: @resource.pictures, resource: @resource }).html_safe,
      newPicture: new_pictures.last.gsub(File.join(Rails.root, 'public'), ''),
      resourceClass: @resource.class.to_s,
      resourceId: @resource.id
    }
  end

  def destroy
    file = Rails.root.join("public/#{URI.decode(params[:id])}")
    render(nothing: true, status: 404) unless File.exist?(file)
    File.delete(file)
  end

  private

  def set_admin_flag
    @admin_flag = current_member.present? && current_member.has_role?(:admin)
  end

  def identify_resource
    @resource = Object.const_get(params[:resource_type]).find(params[:resource_id])
  end

  def authorize
    render nothing: true, status: 403 unless @admin_flag || @resource == current_user
  end
end
