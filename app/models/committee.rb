# Allows members to be placed into a committee for sorting in the directory
class Committee < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :name, :slug, presence: true
  validates :slug, uniqueness: { scope: :deleted }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Model Relationships
  has_many :committee_members
  has_many :members, through: :committee_members

  # Model Methods
end
