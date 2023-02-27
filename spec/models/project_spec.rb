require 'rails_helper'

RSpec.describe Project, type: :model do
  it "is invalid without a name" do
    project = described_class.new(state: "pending")
    project.validate
    expect(project.errors).to be_of_kind(:name, :blank)
  end

  it "is valid with a anme" do
    project = described_class.new(name: "test", state: "pending")
    expect(project).to be_valid
  end

  it "must have a unique name" do
    project = create(:project)
    project = described_class.new(name: project.name, state: "pending")
    project.validate
    expect(project.errors).to be_of_kind(:name, :taken)
  end

  context "state" do
    it "must be set" do
      project = described_class.new(name: "test")
      project.validate
      expect(project.errors).to be_of_kind(:state, :inclusion)
    end

    it "can be pending" do
      project = described_class.new(name: "test", state: "pending")
      expect(project).to be_valid
    end

    it "can be pending" do
      project = described_class.new(name: "test", state: "pending")
      expect(project).to be_valid
    end

    it "can be pending" do
      project = described_class.new(name: "test", state: "pending")
      expect(project).to be_valid
    end

    it "is otherwise invalid" do
      project = described_class.new(name: "test", state: "apples")
      project.validate
      expect(project.errors).to be_of_kind(:state, :inclusion)
    end
  end
end
