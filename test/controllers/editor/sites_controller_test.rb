require 'test_helper'

class Editor::SitesControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @site = sites(:one)
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
      post :create, site: { name: 'Site Three', slug: 'site-three', address: @site.address }
    end
    assert_redirected_to editor_site_path(assigns(:site))
  end

  test 'should not create site as viewer' do
    login(@viewer)
    assert_difference('Site.count', 0) do
      post :create, site: { name: 'Site Three', slug: 'site-three', address: @site.address }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show site as editor' do
    login(@editor)
    get :show, id: @site
    assert_response :success
  end

  test 'should not show site as viewer' do
    login(@viewer)
    get :show, id: @site
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, id: @site
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, id: @site
    assert_redirected_to dashboard_path
  end

  test 'should update site as editor' do
    login(@editor)
    patch :update, id: @site, site: { name: @site.name, slug: @site.slug, address: @site.address }
    assert_redirected_to editor_site_path(assigns(:site))
  end

  test 'should not update site as viewer' do
    login(@viewer)
    patch :update, id: @site, site: { name: @site.name, slug: @site.slug, address: @site.address }
    assert_redirected_to dashboard_path
  end

  test 'should destroy site as editor' do
    login(@editor)
    assert_difference('Site.current.count', -1) do
      delete :destroy, id: @site
    end
    assert_redirected_to editor_sites_path
  end

  test 'should not destroy site as viewer' do
    login(@viewer)
    assert_difference('Site.current.count', 0) do
      delete :destroy, id: @site
    end
    assert_redirected_to dashboard_path
  end
end
