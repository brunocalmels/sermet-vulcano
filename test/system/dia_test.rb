require "application_system_test_case"

class DiaTest < ApplicationSystemTestCase
  setup do
    @dia = dia(:one)
  end

  test "visiting the index" do
    visit dia_url
    assert_selector "h1", text: "Dia"
  end

  test "creating a Dia" do
    visit dia_url
    click_on "New Dia"

    click_on "Create Dia"

    assert_text "Dia was successfully created"
    click_on "Back"
  end

  test "updating a Dia" do
    visit dia_url
    click_on "Edit", match: :first

    click_on "Update Dia"

    assert_text "Dia was successfully updated"
    click_on "Back"
  end

  test "destroying a Dia" do
    visit dia_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dia was successfully destroyed"
  end
end
