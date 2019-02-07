# frozen_string_literal: true

require "test_helper"

# Tests to make sure drugs can be searched.
class DrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drug = drugs(:one)
  end

  test "should get index" do
    get drugs_url
    assert_response :success
  end

  test "should show drug" do
    get drug_url(@drug)
    assert_response :success
  end
end
