require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  test "viewing the index" do
    visit root_path
    assert_selector "h1", text: "The future of moving is here."
  end
end
