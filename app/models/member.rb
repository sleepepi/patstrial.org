# Members are directory listings that can be seen from dashboard
class Member < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :first_name, :last_name, presence: true

  # Model Relationships
  belongs_to :site
  has_many :committee_members
  has_many :committees, -> { order(:position) }, through: :committee_members

  # Model Methods

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
