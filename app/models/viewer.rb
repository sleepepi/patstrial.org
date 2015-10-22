# Allows generic username password logins for read-only access to internal site
class Viewer < ActiveRecord::Base
  has_secure_password

  # Model Validation
  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: /\A[a-zA-Z][a-zA-Z0-9]*\Z/ }
  validates :password, presence: true

  # Model Methods
end
