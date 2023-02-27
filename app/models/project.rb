class Project < ApplicationRecord
  VALID_STATES = %w[pending in_progress completed]

  validates :name, presence: true, uniqueness: true
  validates :state, inclusion: VALID_STATES
end
