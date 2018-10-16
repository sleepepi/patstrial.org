# frozen_string_literal: true

require "application_system_test_case"

# Test external pages.
class ExternalTest < ApplicationSystemTestCase
  test "visiting the privacy policy page" do
    visit privacy_policy_url
    screenshot("visit-privacy-policy-page")
  end

  test "visiting the version page" do
    visit version_url
    sleep(2.0) # Allow time for logo to finish animating
    screenshot("visit-version-page")
  end
end
