require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    # TODO: look into moving base_title into some generic all_tests structure
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

end
