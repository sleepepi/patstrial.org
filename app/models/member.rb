# frozen_string_literal: true

# Members are directory listings that can be seen from dashboard.
class Member < ApplicationRecord
  # Concerns
  include Deletable

  # Validations
  validates :first_name, :last_name, presence: true

  # Relationships
  belongs_to :site, optional: true
  has_many :committee_members
  has_many :committees, -> { order(:position) }, through: :committee_members

  # Methods

  def name
    "#{first_name} #{last_name}"
  end

  def name_was
    "#{first_name_was} #{last_name_was}"
  end

  def name_reverse
    "#{last_name}, #{first_name}"
  end
end
