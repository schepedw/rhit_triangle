class ProjectsController < ApplicationController
  before_action :require_admin_role, except: :index
  before_action :set_admin_flag

  def index
    completed_status = ProjectStatus.find_or_create_by(status: 'Complete')
    @projects = Project.includes(:donations).where.not("price = 0 or project_status_id = #{completed_status.id}")
  end

  def create
    @project = Project.create!(
      project_params.merge(project_status_id: ProjectStatus.find_by_status('Unstarted').id)
    )
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy!
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
  end

  def complete
    @project = Project.find(params[:project_id])
    status = ProjectStatus.find_or_create_by(status: 'Complete')
    @project.update(project_status_id: status.id)
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :price, pictures: [])
  end
end
