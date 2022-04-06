require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
  test "can see the home page" do
    get "/"
    assert_select "h1", "The future of moving is here."
  end
end
