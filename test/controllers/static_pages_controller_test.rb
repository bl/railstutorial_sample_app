require 'test_helper'

# Controller inferred by class name (ie StaticPages|ControllerTest)
class StaticPagesControllerTest < ActionController::TestCase
  # can specifically infer a controller by using
  # tests StaticPagesController

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
