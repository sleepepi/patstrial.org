# frozen_string_literal: true

require 'test_helper'

class Editor::CommitteesControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @committee = committees(:one)
  end

  def committee_params
    { name: 'New Committee', slug: 'new-committee' }
  end

  test 'should get index as editor' do
    login(@editor)
    get :index
    assert_response :success
    assert_not_nil assigns(:committees)
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

  test 'should create committee as editor' do
    login(@editor)
    assert_difference('Committee.count') do
      post :create, params: { committee: committee_params }
    end
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not create committee with blank name' do
    login(@editor)
    assert_difference('Committee.count', 0) do
      post :create, params: { committee: committee_params.merge(name: '') }
    end
    assert_not_nil assigns(:committee)
    assert assigns(:committee).errors.size > 0
    assert_equal ["can't be blank"], assigns(:committee).errors[:name]
    assert_template 'new'
  end

  test 'should not create committee as viewer' do
    login(@viewer)
    assert_difference('Committee.count', 0) do
      post :create, params: { committee: committee_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show committee as editor' do
    login(@editor)
    get :show, params: { id: @committee }
    assert_response :success
  end

  test 'should not show committee as viewer' do
    login(@viewer)
    get :show, params: { id: @committee }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, params: { id: @committee }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, params: { id: @committee }
    assert_redirected_to dashboard_path
  end

  test 'should update committee as editor' do
    login(@editor)
    patch :update, params: { id: @committee, committee: committee_params }
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not update committee with blank name' do
    login(@editor)
    patch :update, params: { id: @committee, committee: committee_params.merge(name: '') }
    assert_not_nil assigns(:committee)
    assert assigns(:committee).errors.size > 0
    assert_equal ["can't be blank"], assigns(:committee).errors[:name]
    assert_template 'edit'
  end

  test 'should not update committee as viewer' do
    login(@viewer)
    patch :update, params: { id: @committee, committee: committee_params }
    assert_redirected_to dashboard_path
  end

  test 'should destroy committee as editor' do
    login(@editor)
    assert_difference('Committee.current.count', -1) do
      delete :destroy, params: { id: @committee }
    end
    assert_redirected_to editor_committees_path
  end

  test 'should not destroy committee as viewer' do
    login(@viewer)
    assert_difference('Committee.current.count', 0) do
      delete :destroy, params: { id: @committee }
    end
    assert_redirected_to dashboard_path
  end
end
