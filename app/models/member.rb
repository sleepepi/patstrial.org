# Members are directory listings that can be seen from dashboard
class Member < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :first_name, :last_name, presence: true

  # Model Methods

  def name
    "#{first_name} #{last_name}"
  end

  def name_was
    "#{first_name_was} #{last_name_was}"
  end
end
