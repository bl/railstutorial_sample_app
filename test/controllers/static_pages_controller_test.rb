require 'test_helper'

# Controller inferred by class name (ie StaticPages|ControllerTest)
class StaticPagesControllerTest < ActionController::TestCase
  # can specifically infer a controller by using
  # tests StaticPagesController
  
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", full_title
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", full_title("Help")
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", full_title("About")
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", full_title("Contact")
  end

end
