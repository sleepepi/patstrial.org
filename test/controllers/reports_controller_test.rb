# frozen_string_literal: true

require 'test_helper'

# Tests to assure that reports load correctly.
class ReportsControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
  end

  test 'should get screened' do
    login(@viewer)
    get :screened
    assert_response :success
  end

  test 'should get consented' do
    login(@viewer)
    get :consented
    assert_response :success
  end

  test 'should get eligible' do
    login(@viewer)
    get :eligible
    assert_response :success
  end

  test 'should get randomized' do
    login(@viewer)
    get :randomized
    assert_response :success
  end

  test 'should get demographics' do
    login(@viewer)
    get :demographics
    assert_response :success
  end
end