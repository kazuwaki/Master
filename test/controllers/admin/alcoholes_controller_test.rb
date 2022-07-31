require "test_helper"

class Admin::AlcoholesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_alcoholes_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_alcoholes_edit_url
    assert_response :success
  end
end
