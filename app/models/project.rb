class Project < ApplicationRecord
  VALID_STATES = %w[pending in_progress completed]

  validates :name, presence: true, uniqueness: true
  validates :state, inclusion: VALID_STATES

  has_many :comments

  def next_state
    next_sttae_position = (VALID_STATES.index(state) + 1) % 3
    VALID_STATES[next_sttae_position]
  end
end
