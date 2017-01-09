# frozen_string_literal: true

require 'test_helper'

# Tests accessibility of public static pages on the website
class ApplicationControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
  end

  test 'should get credits' do
    get :credits
    assert_response :success
  end

  test 'should get version' do
    get :version
    assert_response :success
  end

  test 'should get version as json' do
    get :version, format: 'json'
    version = JSON.parse(response.body)
    assert_equal PatstrialOrg::VERSION::STRING, version['version']['string']
    assert_equal PatstrialOrg::VERSION::MAJOR, version['version']['major']
    assert_equal PatstrialOrg::VERSION::MINOR, version['version']['minor']
    assert_equal PatstrialOrg::VERSION::TINY, version['version']['tiny']
    if PatstrialOrg::VERSION::BUILD.nil?
      assert_nil version['version']['build']
    else
      assert_equal PatstrialOrg::VERSION::BUILD, version['version']['build']
    end
    assert_response :success
  end
end
