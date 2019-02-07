# frozen_string_literal: true

require "test_helper"

# Allow editors to update folders.
class Editor::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @category = categories(:one)
  end

  def category_params
    {
      name: "New Category",
      description: @category.description,
      top_level: @category.top_level,
      slug: "new-category",
      position: @category.position,
      archived: @category.archived
    }
  end

  test "should get index as editor" do
    login(@editor)
    get editor_categories_url
    assert_response :success
  end

  test "should not get index as viewer" do
    login(@viewer)
    get editor_categories_url
    assert_redirected_to dashboard_url
  end

  test "should get new as editor" do
    login(@editor)
    get new_editor_category_url
    assert_response :success
  end

  test "should not get new as viewer" do
    login(@viewer)
    get new_editor_category_url
    assert_redirected_to dashboard_url
  end

  test "should create category as editor" do
    login(@editor)
    assert_difference("Category.count") do
      post editor_categories_url, params: { category: category_params }
    end
    assert_redirected_to editor_category_url(assigns(:category))
  end

  test "should not create category with blank name" do
    login(@editor)
    assert_difference("Category.count", 0) do
      post editor_categories_url, params: { category: category_params.merge(name: "") }
    end
    assert_response :success
  end

  test "should not create category as viewer" do
    login(@viewer)
    assert_difference("Category.count", 0) do
      post editor_categories_url, params: { category: category_params }
    end
    assert_redirected_to dashboard_url
  end

  test "should show category as editor" do
    login(@editor)
    get editor_category_url(@category)
    assert_response :success
  end

  test "should not show category as viewer" do
    login(@viewer)
    get editor_category_url(@category)
    assert_redirected_to dashboard_url
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_editor_category_url(@category)
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer)
    get edit_editor_category_url(@category)
    assert_redirected_to dashboard_url
  end

  test "should update category as editor" do
    login(@editor)
    patch editor_category_url(@category), params: { category: category_params }
    assert_redirected_to editor_category_url(assigns(:category))
  end

  test "should not update category with blank name" do
    login(@editor)
    patch editor_category_url(@category), params: { category: category_params.merge(name: "") }
    assert_response :success
  end

  test "should not update category as viewer" do
    login(@viewer)
    patch editor_category_url(@category), params: { category: category_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy category as editor" do
    login(@editor)
    assert_difference("Category.current.count", -1) do
      delete editor_category_url(@category)
    end
    assert_redirected_to editor_categories_url
  end

  test "should not destroy category as viewer" do
    login(@viewer)
    assert_difference("Category.current.count", 0) do
      delete editor_category_url(@category)
    end
    assert_redirected_to dashboard_url
  end
end
