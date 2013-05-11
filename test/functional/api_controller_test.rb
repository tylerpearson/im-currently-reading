require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get books" do
    get :books
    assert_response :success
  end

end
