require "test_helper"

class User::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get user_searches_find_url
    assert_response :success
  end

  test "should get index" do
    get user_searches_index_url
    assert_response :success
  end
end
