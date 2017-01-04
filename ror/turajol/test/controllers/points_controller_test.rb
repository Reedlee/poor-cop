require 'test_helper'

class PointsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get points_show_url
    assert_response :success
  end

end
