require "test_helper"

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get api_v1_movies_search_url
    assert_response :success
  end
end
