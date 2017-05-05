# frozen_string_literal: true

# Associates a committee with a member. Members can be part of multiple
# committees
class CommitteeMember < ApplicationRecord
  # Validations
  validates :committee_id, :member_id, presence: true
  validates :member_id, uniqueness: { scope: :committee_id, message: 'is already on committee' }

  # Relationships
  belongs_to :committee
  belongs_to :member

  # Methods
end
