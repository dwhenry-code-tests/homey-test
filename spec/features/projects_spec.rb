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

  it "can set the project state"
  it "can add a project comment"
  it "limits the number of visible comments"
end