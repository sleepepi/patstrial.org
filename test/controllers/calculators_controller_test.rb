# frozen_string_literal: true

require "test_helper"

# Tests for public calculators.
class CalculatorsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to bmi zscore" do
    get calculators_url
    assert_redirected_to calculators_bmi_zscore_url
  end

  test "should get bmi zscore" do
    get calculators_bmi_zscore_url
    assert_response :success
  end

  test "should get bmi zscore result" do
    get calculators_bmi_zscore_result_url
    assert_response :success
  end
end
