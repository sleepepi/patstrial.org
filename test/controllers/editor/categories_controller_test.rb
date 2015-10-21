require 'test_helper'

class Editor::CategoriesControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @category = categories(:one)
  end

  test 'should get index as editor' do
    login(@editor)
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
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

  test 'should create category as editor' do
    login(@editor)
    assert_difference('Category.count') do
      post :create, category: { name: 'New Category', description: @category.description, top_level: @category.top_level, slug: 'new-category', position: @category.position, archived: @category.archived }
    end
    assert_redirected_to category_path(assigns(:category))
  end

  test 'should not create category as viewer' do
    login(@viewer)
    assert_difference('Category.count', 0) do
      post :create, category: { name: 'New Category', description: @category.description, top_level: @category.top_level, slug: 'new-category', position: @category.position, archived: @category.archived }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show category as editor' do
    login(@editor)
    get :show, id: @category
    assert_response :success
  end

  test 'should not show category as viewer' do
    login(@viewer)
    get :show, id: @category
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, id: @category
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, id: @category
    assert_redirected_to dashboard_path
  end

  test 'should update category as editor' do
    login(@editor)
    patch :update, id: @category, category: { name: @category.name, description: @category.description, top_level: @category.top_level, slug: @category.slug, position: @category.position, archived: @category.archived }
    assert_redirected_to category_path(assigns(:category))
  end

  test 'should not update category as viewer' do
    login(@viewer)
    patch :update, id: @category, category: { name: @category.name, description: @category.description, top_level: @category.top_level, slug: @category.slug, position: @category.position, archived: @category.archived }
    assert_redirected_to dashboard_path
  end

  test 'should destroy category as editor' do
    login(@editor)
    assert_difference('Category.current.count', -1) do
      delete :destroy, id: @category
    end
    assert_redirected_to categories_path
  end

  test 'should not destroy category as viewer' do
    login(@viewer)
    assert_difference('Category.current.count', 0) do
      delete :destroy, id: @category
    end
    assert_redirected_to dashboard_path
  end
end
