# frozen_string_literal: true

require 'simplecov'
require 'minitest/pride'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Set up ActiveSupport tests
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# Set up ActionController tests
class ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def login(resource)
    @request.env['devise.mapping'] = Devise.mappings[resource]
    sign_in(resource, scope: resource.class.name.downcase.to_sym)
  end

  def login_viewer(resource)
    session[:viewer_id] = resource.id
  end
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user, password)
    user.update password: password, password_confirmation: password
    post_via_redirect '/login', user: { email: user.email, password: password }
    user
  end

  def sign_in_as_viewer(viewer)
    viewer.update password: viewer.password_plain, password_confirmation: viewer.password_plain
    post_via_redirect '/login', user: { email: viewer.username, password: viewer.password_plain }
  end
end

module Rack
  module Test
    class UploadedFile
      attr_reader :tempfile
    end
  end
end
