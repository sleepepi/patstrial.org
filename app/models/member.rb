# frozen_string_literal: true

# Members are directory listings that can be seen from dashboard.
class Member < ApplicationRecord
  # Constants
  ORDERS = {
    "name desc" => "members.last_name desc, members.first_name desc",
    "name" => "members.last_name, members.first_name"
  }
  DEFAULT_ORDER = "members.last_name, members.first_name"

  # Concerns
  include Deletable

  include Searchable
  def self.searchable_attributes
    %w(first_name last_name email role staffid)
  end

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
