class ProjectsController < ApplicationController
  def index
    projects = Project.all

    render locals: { projects: projects }
  end

  def new
    project = Project.new

    render locals: { project: project }
  end

  def create
    project = Project.new(project_params)

    if project.save
      redirect_to projects_path
    else
      render :new, locals: { project: project }
    end
  end

  def show
    project = Project.find(params[:id])

    render locals: { project: project }
  end

  private

  def project_params
    params.require(:project).permit(:name).merge(state: "pending")
  end
end