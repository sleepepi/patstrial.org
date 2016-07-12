# frozen_string_literal: true

require 'test_helper'

class Editor::SitesControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @site = sites(:one)
  end

  def site_params
    { name: 'Site Three', slug: 'site-three', address: @site.address }
  end

  test 'should get index as editor' do
    login(@editor)
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index
    assert_redirected_to dashboard_path
  end

  test 'should get new as editor' do
    login(@editor)
    get :new
    assert_response :success
  end

  test 'should not get new as viewer' do
    login(@viewer)
    get :new
    assert_redirected_to dashboard_path
  end

  test 'should create site as editor' do
    login(@editor)
    assert_difference('Site.count') do
      post :create, params: { site: site_params }
    end
    assert_redirected_to editor_site_path(assigns(:site))
  end

  test 'should not create site with blank name' do
    login(@editor)
    assert_difference('Site.count', 0) do
      post :create, params: { site: site_params.merge(name: '') }
    end
    assert_not_nil assigns(:site)
    assert assigns(:site).errors.size > 0
    assert_equal ["can't be blank"], assigns(:site).errors[:name]
    assert_template 'new'
  end

  test 'should not create site as viewer' do
    login(@viewer)
    assert_difference('Site.count', 0) do
      post :create, params: { site: site_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show site as editor' do
    login(@editor)
    get :show, params: { id: @site }
    assert_response :success
  end

  test 'should not show site as viewer' do
    login(@viewer)
    get :show, params: { id: @site }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, params: { id: @site }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, params: { id: @site }
    assert_redirected_to dashboard_path
  end

  test 'should update site as editor' do
    login(@editor)
    patch :update, params: { id: @site, site: site_params }
    assert_redirected_to editor_site_path(assigns(:site))
  end

  test 'should update site with blank name' do
    login(@editor)
    patch :update, params: { id: @site, site: site_params.merge(name: '') }
    assert_not_nil assigns(:site)
    assert assigns(:site).errors.size > 0
    assert_equal ["can't be blank"], assigns(:site).errors[:name]
    assert_template 'edit'
  end

  test 'should not update site as viewer' do
    login(@viewer)
    patch :update, params: { id: @site, site: site_params }
    assert_redirected_to dashboard_path
  end

  test 'should destroy site as editor' do
    login(@editor)
    assert_difference('Site.current.count', -1) do
      delete :destroy, params: { id: @site }
    end
    assert_redirected_to editor_sites_path
  end

  test 'should not destroy site as viewer' do
    login(@viewer)
    assert_difference('Site.current.count', 0) do
      delete :destroy, params: { id: @site }
    end
    assert_redirected_to dashboard_path
  end
end
