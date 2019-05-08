require "application_system_test_case"

class ReportRowsTest < ApplicationSystemTestCase
  setup do
    @report_row = report_rows(:one)
  end

  test "visiting the index" do
    visit report_rows_url
    assert_selector "h1", text: "Report Rows"
  end

  test "creating a Report row" do
    visit report_rows_url
    click_on "New Report Row"

    click_on "Create Report row"

    assert_text "Report row was successfully created"
    click_on "Back"
  end

  test "updating a Report row" do
    visit report_rows_url
    click_on "Edit", match: :first

    click_on "Update Report row"

    assert_text "Report row was successfully updated"
    click_on "Back"
  end

  test "destroying a Report row" do
    visit report_rows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Report row was successfully destroyed"
  end
end
