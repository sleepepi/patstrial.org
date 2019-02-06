# frozen_string_literal: true

require "test_helper"

# Tests to assure that reports load correctly.
class ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
  end

  test "should get data quality" do
    login(@viewer)
    get reports_data_quality_url
    assert_response :success
  end

  test "should get screened" do
    login(@viewer)
    get reports_screened_url
    assert_response :success
  end

  test "should get consented" do
    login(@viewer)
    get reports_consented_url
    assert_response :success
  end

  test "should get eligible" do
    login(@viewer)
    get reports_eligible_url
    assert_response :success
  end

  test "should get randomized" do
    login(@viewer)
    get reports_randomized_url
    assert_response :success
  end

  test "should get demographics" do
    login(@viewer)
    get reports_demographics_url
    assert_response :success
  end

  test "should get eligibility status" do
    login(@viewer)
    get reports_eligibility_status_url
    assert_redirected_to reports_eligibility_status_screened_path
  end

  test "should get eligibility status screened" do
    login(@viewer)
    get reports_eligibility_status_screened_url
    assert_response :success
  end

  test "should get eligibility status consented" do
    login(@viewer)
    get reports_eligibility_status_consented_url
    assert_response :success
  end

  test "should get grades" do
    login(@viewer)
    get reports_grades_url
    assert_response :success
  end

  test "should get unscheduled events" do
    login(@viewer)
    get reports_unscheduled_events_url
    assert_response :success
  end

  test "should get failing checks" do
    login(@viewer)
    get reports_data_inconsistencies_url
    assert_response :success
  end
end
