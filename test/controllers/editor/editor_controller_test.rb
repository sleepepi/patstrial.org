# frozen_string_literal: true

require 'test_helper'

# Tests access permissions to editor dashboard controller
class Editor::EditorControllerTest < ActionController::TestCase
  setup do
    @editor = users(:editor)
    @viewer = users(:viewer)
    @pending = users(:pending)
  end

  test 'should get index as editor' do
    login(@editor)
    get :index
    assert_redirected_to setup_path
  end

  test 'should not get index as viewer' do
    login(@viewer)
    get :index
    assert_redirected_to dashboard_path
  end

  test 'should not get index as pending user' do
    login(@pending)
    get :index
    assert_redirected_to new_user_session_path
  end

  test 'should not get index as anonymous user' do
    get :index
    assert_redirected_to new_user_session_path
  end
end
