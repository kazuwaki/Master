require "test_helper"

class Admin::TimeLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_time_lines_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_time_lines_show_url
    assert_response :success
  end
end
