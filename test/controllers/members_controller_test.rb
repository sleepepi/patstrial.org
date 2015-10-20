require 'test_helper'

# Editors should be able to create and update member directory listings
class MembersControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @member = members(:one)
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
      post :create, member: { first_name: @member.first_name, last_name: @member.last_name, email: @member.email, phone: @member.phone, role: @member.role }
    end
    assert_redirected_to member_path(assigns(:member))
  end

  test 'should not create member as viewer' do
    login(@viewer)
    assert_difference('Member.count', 0) do
      post :create, member: { first_name: @member.first_name, last_name: @member.last_name, email: @member.email, phone: @member.phone, role: @member.role }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show member as editor' do
    login(@editor)
    get :show, id: @member
    assert_response :success
  end

  test 'should not show member as viewer' do
    login(@viewer)
    get :show, id: @member
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, id: @member
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, id: @member
    assert_redirected_to dashboard_path
  end

  test 'should update member as editor' do
    login(@editor)
    patch :update, id: @member, member: { first_name: @member.first_name, last_name: @member.last_name, email: @member.email, phone: @member.phone, role: @member.role }
    assert_redirected_to member_path(assigns(:member))
  end

  test 'should not update member as viewer' do
    login(@viewer)
    patch :update, id: @member, member: { first_name: @member.first_name, last_name: @member.last_name, email: @member.email, phone: @member.phone, role: @member.role }
    assert_redirected_to dashboard_path
  end

  test 'should destroy member as editor' do
    login(@editor)
    assert_difference('Member.current.count', -1) do
      delete :destroy, id: @member
    end
    assert_redirected_to members_path
  end

  test 'should not destroy member as viewer' do
    login(@viewer)
    assert_difference('Member.current.count', 0) do
      delete :destroy, id: @member
    end
    assert_redirected_to dashboard_path
  end
end
