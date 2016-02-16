# frozen_string_literal: true

require 'test_helper'

SimpleCov.command_name 'test:integration'

# Tests sign in navigation for various users
class NavigationTest < ActionDispatch::IntegrationTest
  test 'regular users should be able to login' do
    get '/dashboard'
    assert_redirected_to new_user_session_path

    sign_in_as(users(:viewer), '123456')
    assert_equal '/dashboard', path
    assert_equal I18n.t('devise.sessions.signed_in'), flash[:notice]
  end

  test 'generic viewers should be able to login' do
    get '/dashboard'
    assert_redirected_to new_user_session_path

    sign_in_as_viewer(viewers(:one))
    assert_equal '/dashboard', path
  end

  test 'generic viewers should be able to logout' do
    sign_in_as_viewer(viewers(:one))
    assert_equal '/dashboard', path

    get '/logout'
    assert_redirected_to '/'

    get '/dashboard'
    assert_redirected_to new_user_session_path
  end

  test 'deleted users should be not be allowed to login' do
    get '/dashboard'
    assert_redirected_to new_user_session_path

    sign_in_as(users(:deleted), '123456')
    assert_equal new_user_session_path, path
    assert_equal I18n.t('devise.failure.inactive'), flash[:alert]
  end

  test 'users who are pending approval should be not be allowed to login' do
    get '/dashboard'
    assert_redirected_to new_user_session_path

    sign_in_as(users(:pending), '123456')
    assert_equal new_user_session_path, path
    assert_equal I18n.t('devise.failure.inactive'), flash[:alert]
  end

  test 'root navigation redirected to login page' do
    get '/dashboard'
    assert_redirected_to new_user_session_path
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end
end
