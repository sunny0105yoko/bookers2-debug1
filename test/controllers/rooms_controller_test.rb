require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get messages" do
    get rooms_messages_url
    assert_response :success
  end
end
