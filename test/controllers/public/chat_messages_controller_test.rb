require "test_helper"

class Public::ChatMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_chat_messages_index_url
    assert_response :success
  end
end
