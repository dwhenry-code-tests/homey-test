# have used a generic System comment type here instead of a specific `state` comment
# type as this feel like it has greater reuse. This would need to be review once/if
# additional System comment are added.
class Comment
  class System < ::Comment
    def self.build!(project:)
      value = "State changed from #{project.state.humanize} to #{project.next_state.humanize}"
      create!(value: value, project: project)
    end
  end
end