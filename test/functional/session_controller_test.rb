require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new,create,destroy" do
    get :new,create,destroy
    assert_response :success
  end

end
