# frozen_string_literal: true

require "simplecov"
require "minitest/pride"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Set up ActiveSupport tests.
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# Set up ActionController tests
# TODO: Remove ActionController Tests
class ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def login(resource)
    @request.env["devise.mapping"] = Devise.mappings[resource]
    sign_in(resource, scope: resource.class.name.downcase.to_sym)
  end

  def login_viewer(resource)
    session[:viewer_id] = resource.id
  end
end

# Set up ActionDispatch tests
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def login(user)
    sign_in_as(user, "1234567890")
  end

  def login_viewer(viewer)
    sign_in_as_viewer(viewer)
  end

  def sign_in_as(user, password)
    user.update password: password, password_confirmation: password
    post new_user_session_url, params: { user: { email: user.email, password: password } }
    follow_redirect!
    user
  end

  def sign_in_as_viewer(viewer)
    viewer.update password: viewer.password_plain, password_confirmation: viewer.password_plain
    post new_user_session_url, params: { user: { email: viewer.username, password: viewer.password_plain } }
    follow_redirect!
    viewer
  end
end

module Rack
  module Test
    # Allow files to be uploaded in tests.
    class UploadedFile
      attr_reader :tempfile
    end
  end
end
