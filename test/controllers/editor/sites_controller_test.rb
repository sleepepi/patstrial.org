# frozen_string_literal: true

require "test_helper"

# Allows editors to manage sites.
class Editor::SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @site = sites(:one)
  end

  def site_params
    {
      name: "Site Three",
      slug: "site-three",
      address: "123 Road Way",
      number: "3"
    }
  end

  test "should get index as editor" do
    login(@editor)
    get editor_sites_url
    assert_response :success
    assert_not_nil assigns(:sites)
  end

  test "should not get index as viewer" do
    login(@viewer)
    get editor_sites_url
    assert_redirected_to dashboard_url
  end

  test "should get new as editor" do
    login(@editor)
    get new_editor_site_url
    assert_response :success
  end

  test "should not get new as viewer" do
    login(@viewer)
    get new_editor_site_url
    assert_redirected_to dashboard_url
  end

  test "should create site as editor" do
    login(@editor)
    assert_difference("Site.count") do
      post editor_sites_url, params: { site: site_params }
    end
    assert_redirected_to editor_site_url(assigns(:site))
  end

  test "should not create site with blank name" do
    login(@editor)
    assert_difference("Site.count", 0) do
      post editor_sites_url, params: { site: site_params.merge(name: "") }
    end
    assert_response :success
  end

  test "should not create site as viewer" do
    login(@viewer)
    assert_difference("Site.count", 0) do
      post editor_sites_url, params: { site: site_params }
    end
    assert_redirected_to dashboard_url
  end

  test "should show site as editor" do
    login(@editor)
    get editor_site_url(@site)
    assert_response :success
  end

  test "should not show site as viewer" do
    login(@viewer)
    get editor_site_url(@site)
    assert_redirected_to dashboard_url
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_editor_site_url(@site)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_editor_site_url(@site)
    assert_redirected_to dashboard_url
  end

  test "should update site as editor" do
    login(@editor)
    patch editor_site_url(@site), params: { site: site_params }
    @site.reload
    assert_equal "Site Three", @site.name
    assert_equal "site-three", @site.slug
    assert_equal "123 Road Way", @site.address
    assert_equal 3, @site.number
    assert_redirected_to editor_site_url(assigns(:site))
  end

  test "should update site with blank name" do
    login(@editor)
    patch editor_site_url(@site), params: { site: site_params.merge(name: "") }
    assert_response :success
  end

  test "should not update site as viewer" do
    login(@viewer)
    patch editor_site_url(@site), params: { site: site_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy site as editor" do
    login(@editor)
    assert_difference("Site.current.count", -1) do
      delete editor_site_url(@site)
    end
    assert_redirected_to editor_sites_url
  end

  test "should not destroy site as viewer" do
    login(@viewer)
    assert_difference("Site.current.count", 0) do
      delete editor_site_url(@site)
    end
    assert_redirected_to dashboard_url
  end
end
