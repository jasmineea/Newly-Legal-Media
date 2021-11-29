require 'test_helper'

class PoliticControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get politic_index_url
    assert_response :success
  end

end
