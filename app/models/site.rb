# Members can belong to a single site. Sites are displayed publicly on website
class Site < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :name, :slug, :address, presence: true
  validates :slug, uniqueness: { scope: :deleted }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Model Relationships
  has_many :members, -> { order(:last_name, :first_name) }

  # Model Methods
end