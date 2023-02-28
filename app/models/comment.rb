class Comment < ApplicationRecord
  belongs_to :project, optional: true

  scope :recent, -> (limit) do
    order(:id).last(limit)
  end
end
