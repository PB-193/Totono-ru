require "test_helper"

class Admin::ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_contents_show_url
    assert_response :success
  end
end
