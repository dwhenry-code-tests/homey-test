class Comment
  class User < Comment
    belongs_to :user, class_name: "::User"
  end
end
