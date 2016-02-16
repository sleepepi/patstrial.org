# frozen_string_literal: true

require 'test_helper'

# Viewers, editors, and admins should be able to see static internal pages
class InternalControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
    @generic_viewer = viewers(:one)
  end

  test 'should get dashboard as viewer' do
    login(@viewer)
    get :dashboard
    assert_response :success
  end

  test 'should get dashboard as generic viewer' do
    login_viewer(@generic_viewer)
    get :dashboard
    assert_response :success
  end

  test 'should not get dashboard as anonymous user' do
    get :dashboard
    assert_redirected_to new_user_session_path
  end

  test 'should get directory as viewer' do
    login(@viewer)
    get :directory
    assert_response :success
  end

  test 'should get directory as generic viewer' do
    login_viewer(@generic_viewer)
    get :directory
    assert_response :success
  end

  test 'should not get directory as anonymous user' do
    get :directory
    assert_redirected_to new_user_session_path
  end

  test 'should get category as viewer' do
    login(@viewer)
    get :category, category: categories(:one).slug
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test 'should get category as generic viewer' do
    login_viewer(@generic_viewer)
    get :category, category: categories(:one).slug
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test 'should not get category as anonymous user' do
    get :category, category: categories(:one)
    assert_nil assigns(:category)
    assert_redirected_to new_user_session_path
  end

  test 'should download document as viewer' do
    login(@viewer)
    get :document, category: categories(:one).slug, document_id: documents(:two)
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url)), response.body
    assert_response :success
  end

  test 'should download PDF as viewer' do
    login(@viewer)
    get :document, category: categories(:one).slug, document_id: documents(:pdf)
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url)), response.body
    assert_response :success
  end

  test 'should download document as generic viewer' do
    login_viewer(@generic_viewer)
    get :document, category: categories(:one).slug, document_id: documents(:two)
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url)), response.body
    assert_response :success
  end

  test 'should not download document as anonymous user' do
    get :document, category: categories(:one).slug, document_id: documents(:two)
    assert_nil assigns(:category)
    assert_nil assigns(:document)
    assert_redirected_to new_user_session_path
  end
end
