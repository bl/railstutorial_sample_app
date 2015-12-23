require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    @invalid_users = [ 
        {name: "", email: "", password: "", password_confirmation: ""},
        {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"},
        {name: "test", email: "valid@email.com", password: "abc", password_confirmation: "abc"},
        {name: "test", email: "valid@email.com", password: "abc", password_confirmation: "abcd"},
        {name: "test", email: "valid@email.com", password: "foobar123", password_confirmation: "foobar124"}
      ]
    @valid_users = [
        {name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar"}
      ]
  end

  test "invalid signup information" do
    get signup_path # technically unrelated to post, but completeness (and verify valid get)
    # verify no invalid user hashes are successfully saved
    @invalid_users.each do |u|
      assert_no_difference 'User.count' do
        post users_path, user: u
      end
      assert_template 'users/new'
    end
  end

  test "valid signup information " do
    get signup_path # technically unrelated to post, but completeness (and verify valid get)
    @valid_users.each do |u|
      assert_difference 'User.count', 1 do
        post_via_redirect users_path, user: u
      end
      assert_template 'users/show'
    end
  end
end
