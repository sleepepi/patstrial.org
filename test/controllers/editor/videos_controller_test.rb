# frozen_string_literal: true

require 'test_helper'

# Editors should be able to embed videos on categories
class Editor::VideosControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @category = categories(:learn)
    @video = videos(:one)
  end

  def video_params
    {
      name: 'YouTube Video',
      embed_url: 'http://www.youtube.com',
      archived: @video.archived
    }
  end

  test 'should get index as editor' do
    login(@editor)
    get :index, params: { category_id: @category }
    assert_not_nil assigns(:category)
    assert_not_nil assigns(:videos)
    assert_response :success
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index, params: { category_id: @category }
    assert_nil assigns(:category)
    assert_nil assigns(:videos)
    assert_redirected_to dashboard_path
  end

  test 'should get new as editor' do
    login(@editor)
    get :new, params: { category_id: @category }
    assert_response :success
  end

  test 'should not get new as viewer' do
    login(@viewer)
    get :new, params: { category_id: @category }
    assert_redirected_to dashboard_path
  end

  test 'should create video as editor' do
    login(@editor)
    assert_difference('Video.count') do
      post :create, params: { category_id: @category, video: video_params }
    end
    assert_redirected_to editor_category_video_path(assigns(:category), assigns(:video))
  end

  test 'should not create video with blank name' do
    login(@editor)
    assert_difference('Video.count', 0) do
      post :create, params: { category_id: @category, video: video_params.merge(name: '') }
    end

    assert_not_nil assigns(:video)
    assert assigns(:video).errors.size > 0
    assert_equal ["can't be blank"], assigns(:video).errors[:name]
    assert_template 'new'
  end

  test 'should not create video as viewer' do
    login(@viewer)
    assert_difference('Video.count', 0) do
      post :create, params: { category_id: @category, video: video_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show video as editor' do
    login(@editor)
    get :show, params: { category_id: @category, id: @video }
    assert_response :success
  end

  test 'should not show video as viewer' do
    login(@viewer)
    get :show, params: { category_id: @category, id: @video }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, params: { category_id: @category, id: @video }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, params: { category_id: @category, id: @video }
    assert_redirected_to dashboard_path
  end

  test 'should update video as editor' do
    login(@editor)
    patch :update, params: { category_id: @category, id: @video, video: video_params }
    assert_redirected_to editor_category_video_path(assigns(:category), assigns(:video))
  end

  test 'should not update video with blank name' do
    login(@editor)
    patch :update, params: { category_id: @category, id: @video, video: video_params.merge(name: '') }
    assert_not_nil assigns(:video)
    assert assigns(:video).errors.size > 0
    assert_equal ["can't be blank"], assigns(:video).errors[:name]
    assert_template 'edit'
  end

  test 'should not update video as viewer' do
    login(@viewer)
    patch :update, params: { category_id: @category, id: @video, video: video_params }
    assert_redirected_to dashboard_path
  end

  test 'should destroy video as editor' do
    login(@editor)
    assert_difference('Video.current.count', -1) do
      delete :destroy, params: { category_id: @category, id: @video }
    end
    assert_redirected_to editor_category_videos_path(assigns(:category))
  end

  test 'should not destroy video as viewer' do
    login(@viewer)
    assert_difference('Video.current.count', 0) do
      delete :destroy, params: { category_id: @category, id: @video }
    end
    assert_redirected_to dashboard_path
  end
end
