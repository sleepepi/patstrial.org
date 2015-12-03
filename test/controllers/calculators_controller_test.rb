require 'test_helper'

# Tests for public calculators
class CalculatorsControllerTest < ActionController::TestCase
  test 'should get bmi zscore' do
    get :bmi_zscore
    assert_response :success
  end

  test 'should get bmi zscore result' do
    get :bmi_zscore_result
    assert_response :success
  end

  test 'should get blood pressure percentile' do
    get :blood_pressure_percentile
    assert_response :success
  end
end
