require 'test_helper'

class PersonControllerTest < ActionController::TestCase
  test "should get duplicates" do
    get :duplicates
    assert_response :success
  end

end
