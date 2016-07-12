# frozen_string_literal: true

require 'test_helper'

# Editors should be able to create and update member directory listings
class Editor::MembersControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @member = members(:one)
  end

  def member_params
    {
      first_name: @member.first_name,
      last_name: @member.last_name,
      email: @member.email,
      phone: @member.phone,
      role: @member.role
    }
  end

  test 'should get index as editor' do
    login(@editor)
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
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

  test 'should create member as editor' do
    login(@editor)
    assert_difference('Member.count') do
      post :create, params: { member: member_params }
    end
    assert_redirected_to editor_member_path(assigns(:member))
  end

  test 'should not create member with blank name' do
    login(@editor)
    assert_difference('Member.count', 0) do
      post :create, params: { member: member_params.merge(first_name: '', last_name: '') }
    end
    assert_not_nil assigns(:member)
    assert assigns(:member).errors.size > 0
    assert_equal ["can't be blank"], assigns(:member).errors[:first_name]
    assert_equal ["can't be blank"], assigns(:member).errors[:last_name]
    assert_template 'new'
  end

  test 'should not create member as viewer' do
    login(@viewer)
    assert_difference('Member.count', 0) do
      post :create, params: { member: member_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show member as editor' do
    login(@editor)
    get :show, params: { id: @member }
    assert_response :success
  end

  test 'should not show member as viewer' do
    login(@viewer)
    get :show, params: { id: @member }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, params: { id: @member }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, params: { id: @member }
    assert_redirected_to dashboard_path
  end

  test 'should update member as editor' do
    login(@editor)
    patch :update, params: { id: @member, member: member_params }
    assert_redirected_to editor_member_path(assigns(:member))
  end

  test 'should not update member with blank name' do
    login(@editor)
    patch :update, params: { id: @member, member: member_params.merge(first_name: '', last_name: '') }
    assert_not_nil assigns(:member)
    assert assigns(:member).errors.size > 0
    assert_equal ["can't be blank"], assigns(:member).errors[:first_name]
    assert_equal ["can't be blank"], assigns(:member).errors[:last_name]
    assert_template 'edit'
  end

  test 'should not update member as viewer' do
    login(@viewer)
    patch :update, params: { id: @member, member: member_params }
    assert_redirected_to dashboard_path
  end

  test 'should destroy member as editor' do
    login(@editor)
    assert_difference('Member.current.count', -1) do
      delete :destroy, params: { id: @member }
    end
    assert_redirected_to editor_members_path
  end

  test 'should not destroy member as viewer' do
    login(@viewer)
    assert_difference('Member.current.count', 0) do
      delete :destroy, params: { id: @member }
    end
    assert_redirected_to dashboard_path
  end
end
