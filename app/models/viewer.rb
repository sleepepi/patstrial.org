# frozen_string_literal: true

# Allows generic username password logins for read-only access to internal site.
class Viewer < ApplicationRecord
  has_secure_password

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z][a-zA-Z0-9]*\Z/ }
  validates :password, presence: true, length: { minimum: 6 }

  # Methods

  # Increments the sign in count and tracks the sign in time
  def sign_in!
    increment!(:sign_in_count)
    update_column :current_sign_in_at, Time.zone.now
  end
end
