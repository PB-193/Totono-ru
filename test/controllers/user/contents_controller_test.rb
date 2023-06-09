require "test_helper"

class User::ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_contents_index_url
    assert_response :success
  end

  test "should get show" do
    get user_contents_show_url
    assert_response :success
  end

  test "should get new" do
    get user_contents_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_contents_edit_url
    assert_response :success
  end
end
