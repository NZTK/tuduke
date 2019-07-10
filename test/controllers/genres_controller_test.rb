require 'test_helper'

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_genre_url
    assert_response :success
  end

end
