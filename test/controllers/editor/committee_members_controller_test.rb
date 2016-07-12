# frozen_string_literal: true

require 'test_helper'

class Editor::CommitteeMembersControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @committee = committees(:one)
    @committee_member = committee_members(:one)
  end

  def committee_member_params
    { member_id: members(:three).id }
  end

  test 'should get index and redirect to commmittee as editor' do
    login(@editor)
    get :index, params: { committee_id: @committee }
    assert_not_nil assigns(:committee)
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index, params: { committee_id: @committee }
    assert_nil assigns(:committee)
    assert_redirected_to dashboard_path
  end

  test 'should get new as editor' do
    login(@editor)
    get :new, params: { committee_id: @committee }
    assert_response :success
  end

  test 'should not get new as viewer' do
    login(@viewer)
    get :new, params: { committee_id: @committee }
    assert_redirected_to dashboard_path
  end

  test 'should create committee member as editor' do
    login(@editor)
    assert_difference('CommitteeMember.count') do
      post :create, params: { committee_id: @committee, committee_member: committee_member_params }
    end
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not create committee member without member' do
    login(@editor)
    assert_difference('CommitteeMember.count', 0) do
      post :create, params: { committee_id: @committee, committee_member: committee_member_params.merge(member_id: '') }
    end
    assert_not_nil assigns(:committee_member)
    assert assigns(:committee_member).errors.size > 0
    assert_equal ["can't be blank"], assigns(:committee_member).errors[:member_id]
    assert_template 'new'
  end

  test 'should not create committee member as viewer' do
    login(@viewer)
    assert_difference('CommitteeMember.count', 0) do
      post :create, params: { committee_id: @committee, committee_member: committee_member_params }
    end
    assert_redirected_to dashboard_path
  end

  test 'should show committee member and redirect to committee as editor' do
    login(@editor)
    get :show, params: { committee_id: @committee, id: @committee_member }
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not show committee member as viewer' do
    login(@viewer)
    get :show, params: { committee_id: @committee, id: @committee_member }
    assert_redirected_to dashboard_path
  end

  test 'should get edit as editor' do
    login(@editor)
    get :edit, params: { committee_id: @committee, id: @committee_member }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer)
    get :edit, params: { committee_id: @committee, id: @committee_member }
    assert_redirected_to dashboard_path
  end

  test 'should update committee member as editor' do
    login(@editor)
    patch :update, params: {
      committee_id: @committee,
      id: @committee_member,
      committee_member: committee_member_params
    }
    assert_not_nil assigns(:committee)
    assert_not_nil assigns(:committee_member)
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not update committee member without member' do
    login(@editor)
    patch :update, params: {
      committee_id: @committee,
      id: @committee_member,
      committee_member: committee_member_params.merge(member_id: '')
    }
    assert_not_nil assigns(:committee)
    assert_not_nil assigns(:committee_member)
    assert assigns(:committee_member).errors.size > 0
    assert_equal ["can't be blank"], assigns(:committee_member).errors[:member_id]
    assert_template 'edit'
  end

  test 'should not update committee member as viewer' do
    login(@viewer)
    patch :update, params: {
      committee_id: @committee,
      id: @committee_member,
      committee_member: committee_member_params
    }
    assert_nil assigns(:committee)
    assert_nil assigns(:committee_member)
    assert_redirected_to dashboard_path
  end

  test 'should destroy committee member as editor' do
    login(@editor)
    assert_difference('CommitteeMember.count', -1) do
      delete :destroy, params: { committee_id: @committee, id: @committee_member }
    end
    assert_redirected_to editor_committee_path(assigns(:committee))
  end

  test 'should not destroy committee member as viewer' do
    login(@viewer)
    assert_difference('CommitteeMember.count', 0) do
      delete :destroy, params: { committee_id: @committee, id: @committee_member }
    end
    assert_redirected_to dashboard_path
  end
end
