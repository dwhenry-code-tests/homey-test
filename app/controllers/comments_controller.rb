class CommentsController < ApplicationController
  # this is not 100% restful but have choosen this approach due to speed
  def next
    project = Project.find(params[:project_id])
    project.transaction do
      Comment::System.build!(project: project)
      project.update!(state: project.next_state)
    end

    redirect_to project_path(project)
  end

  def create
    project = Project.find(params[:project_id])
    Comment::User.create(
      project: project,
      user: current_user,
      value: params.dig(:comment, :value)
    )

    redirect_to project_path(project)
  end
end