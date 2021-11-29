require 'test_helper'

class FeedControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get feed_news_url
    assert_response :success
  end

end
