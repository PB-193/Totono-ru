require "test_helper"

class User::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_tags_new_url
    assert_response :success
  end
end
