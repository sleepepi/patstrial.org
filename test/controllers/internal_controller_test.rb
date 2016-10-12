# frozen_string_literal: true

require 'test_helper'

# Viewers, editors, and admins should be able to see static internal pages
class InternalControllerTest < ActionController::TestCase
  setup do
    @viewer = users(:viewer)
    @generic_viewer = viewers(:one)
    @unblinded = users(:unblinded)
    @editor = users(:editor)
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
    get :category, params: { top_level: categories(:one).top_level, category: categories(:one).slug }
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test 'should get category as generic viewer' do
    login_viewer(@generic_viewer)
    get :category, params: { top_level: categories(:one).top_level, category: categories(:one).slug }
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test 'should not get category as anonymous user' do
    get :category, params: { top_level: categories(:one).top_level, category: categories(:one).slug }
    assert_nil assigns(:category)
    assert_redirected_to new_user_session_path
  end

  test 'should get unblinded only category as unblinded user' do
    login(@unblinded)
    get :category, params: { top_level: categories(:unblinded).top_level, category: categories(:unblinded).slug }
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test 'should get unblinded only category as editor' do
    login(@editor)
    get :category, params: { top_level: categories(:unblinded).top_level, category: categories(:unblinded).slug }
    assert_not_nil assigns(:category)
    assert_response :success
  end

  test 'should not get unblinded only category as blinded viewer' do
    login(@viewer)
    get :category, params: { top_level: categories(:unblinded).top_level, category: categories(:unblinded).slug }
    assert_nil assigns(:category)
    assert_redirected_to dashboard_path
  end

  test 'should not get unblinded only category as generic viewer' do
    login_viewer(@generic_viewer)
    get :category, params: { top_level: categories(:unblinded).top_level, category: categories(:unblinded).slug }
    assert_nil assigns(:category)
    assert_redirected_to dashboard_path
  end

  test 'should not get unblinded only category as anonymous viewer' do
    get :category, params: { top_level: categories(:unblinded).top_level, category: categories(:unblinded).slug }
    assert_nil assigns(:category)
    assert_redirected_to new_user_session_path
  end

  test 'should download document as viewer' do
    login(@viewer)
    get :document, params: { top_level: categories(:one).top_level, category: categories(:one).slug, document_id: documents(:two) }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url)), response.body
    assert_response :success
  end

  test 'should download PDF as viewer' do
    login(@viewer)
    get :document, params: { top_level: categories(:one).top_level, category: categories(:one).slug, document_id: documents(:pdf) }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url)), response.body
    assert_response :success
  end

  test 'should download document as generic viewer' do
    login_viewer(@generic_viewer)
    get :document, params: { top_level: categories(:one).top_level, category: categories(:one).slug, document_id: documents(:two) }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:document)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url)), response.body
    assert_response :success
  end

  test 'should not download document as anonymous user' do
    get :document, params: { top_level: categories(:one).top_level, category: categories(:one).slug, document_id: documents(:two) }
    assert_nil assigns(:category)
    assert_nil assigns(:document)
    assert_redirected_to new_user_session_path
  end

  test 'should get video as viewer' do
    login(@viewer)
    get :video, params: { top_level: categories(:learn).top_level, category: categories(:learn).slug, video_id: videos(:one) }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:video)
    assert_response :success
  end

  test 'should get video as generic viewer' do
    login_viewer(@generic_viewer)
    get :video, params: { top_level: categories(:learn).top_level, category: categories(:learn).slug, video_id: videos(:one) }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:video)
    assert_response :success
  end

  test 'should not get video as anonymous viewer' do
    get :video, params: { top_level: categories(:learn).top_level, category: categories(:learn).slug, video_id: videos(:one) }
    assert_nil assigns(:category)
    assert_nil assigns(:video)
    assert_redirected_to new_user_session_path
  end
end
