require "rails_helper"

RSpec.describe "Project management" do
  it "can create a new project" do
    visit root_path
    click_on "Add Project"
    fill_in "Name", with: "Test Project"
    click_on "Create Project"

    expect(page).to have_content("Test Project")
    expect(Project.last).to have_attributes(name: "Test Project", state: "pending")
  end

  it "can naviagte to an existing project" do
    project = create(:project)
    visit root_path

    expect(page).to have_content(project.name)
    within("[data-test-id=project-#{project.id}]") do
      click_on "View"
    end

    expect(page).to have_content("#{project.name} Details:")
  end

  it "can display the different comment types" do
    project = create(:project)
    user_comment = create(:user_comment, project: project)
    system_comment = create(:system_comment, project: project)

    visit project_path(project)

    within("[data-test-id=project-history]") do
      expect(page).to have_content("#{user_comment.value}\nUser:#{user_comment.user.id}\n#{user_comment.created_at.strftime("%H:%M %d %b %Y")}")
      expect(page).to have_content("#{system_comment.value}\n-\n#{system_comment.created_at.strftime("%H:%M %d %b %Y")}")
    end
  end

  it "can set the project state" do
    project = create(:project)

    visit project_path(project)

    click_on "Set to In progress"

    expect(page).to have_content("State changed from Pending to In progress")
  end

  it "can add a project comment" do
    project = create(:project)

    visit project_path(project)

    fill_in "comment_value", with: "Test Comment"
    expect { click_on "Add Comment" }.to change(Comment, :count).by(1)

    comment = Comment.last

    expect(page).to have_content("Test Comment\nUser:#{comment.user_id}\n#{comment.created_at.strftime("%H:%M %d %b %Y")}")
  end

  it "limits the number of visible comments" do
    project = create(:project)
    user_comment1 = create(:user_comment, project: project)
    user_comment2 = create(:user_comment, project: project)
    user_comment3 = create(:user_comment, project: project)
    user_comment4 = create(:user_comment, project: project)

    visit project_path(project)

    expect(page).to have_content("#{user_comment2.value}\nUser:#{user_comment2.user.id}\n#{user_comment2.created_at.strftime("%H:%M %d %b %Y")}")
    expect(page).to have_content("#{user_comment3.value}\nUser:#{user_comment3.user.id}\n#{user_comment3.created_at.strftime("%H:%M %d %b %Y")}")
    expect(page).to have_content("#{user_comment4.value}\nUser:#{user_comment4.user.id}\n#{user_comment4.created_at.strftime("%H:%M %d %b %Y")}")

    expect(page).not_to have_content("#{user_comment1.value}\nUser:#{user_comment1.user.id}\n#{user_comment1.created_at.strftime("%H:%M %d %b %Y")}")
  end
end