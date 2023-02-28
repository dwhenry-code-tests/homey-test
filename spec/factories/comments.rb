FactoryBot.define do
  factory :comment do
    sequence(:value)  { |n| "Comment: #{n}" }
    project

    factory :user_comment, class: "Comment::User" do
      user
    end

    factory :system_comment, class: "Comment::System"
  end
end
