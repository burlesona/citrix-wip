require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get login" do
    get :get_login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_redirected_to root_path
  end
end
