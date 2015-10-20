class Member < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :first_name, :last_name, presence: true

  # Model Methods

  def name
    "#{first_name} #{last_name}"
  end
end
