require "application_system_test_case"

class CeapsTest < ApplicationSystemTestCase
  setup do
    @ceap = ceaps(:one)
  end

  test "visiting the index" do
    visit ceaps_url
    assert_selector "h1", text: "Ceaps"
  end

  test "creating a Ceap" do
    visit ceaps_url
    click_on "New Ceap"

    fill_in "Date", with: @ceap.date
    fill_in "Name", with: @ceap.name
    fill_in "Total spend", with: @ceap.total_spend
    click_on "Create Ceap"

    assert_text "Ceap was successfully created"
    click_on "Back"
  end

  test "updating a Ceap" do
    visit ceaps_url
    click_on "Edit", match: :first

    fill_in "Date", with: @ceap.date
    fill_in "Name", with: @ceap.name
    fill_in "Total spend", with: @ceap.total_spend
    click_on "Update Ceap"

    assert_text "Ceap was successfully updated"
    click_on "Back"
  end

  test "destroying a Ceap" do
    visit ceaps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ceap was successfully destroyed"
  end
end
