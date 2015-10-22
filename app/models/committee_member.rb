# Associates a committee with a member. Members can be part of multiple
# committees
class CommitteeMember < ActiveRecord::Base
  # Model Validation
  validates :committee_id, :member_id, presence: true
  validates :member_id, uniqueness: { scope: :committee_id, message: 'is already on committee' }

  # Model Relationships
  belongs_to :committee
  belongs_to :member

  # Model Methods
end
