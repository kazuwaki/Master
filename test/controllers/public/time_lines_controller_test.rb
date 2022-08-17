# frozen_string_literal: true

require "test_helper"

class Public::TimeLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_time_lines_index_url
    assert_response :success
  end
end
