require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear

    # TODO: move additional test users to fixtures
    @invalid_users = [ 
        {name: "", email: "", password: "", password_confirmation: ""},
        {name: "test", email: "foo@bar.com", password: "", password_confirmation: ""},
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
      #assert_select 'div#error_explanation'
      #assert_select 'div#field_with_errors'
    end
  end

  test "valid signup information with account activation" do
    get signup_path # technically unrelated to post, but completeness (and verify valid get)
    @valid_users.each do |u|
      assert_difference 'User.count', 1 do
        post users_path, user: u
      end
      assert_equal 1, ActionMailer::Base.deliveries.size
      user = assigns(:user)
      assert_not user.activated?
      # try to log in before activation
      log_in_as(user)
      assert_not is_logged_in?
      # invalid activation token
      get edit_account_activation_path("invalid token")
      assert_not is_logged_in?
      # valid activation token, wrong email
      get edit_account_activation_path(user.activation_token, email: 'wrong')
      assert_not is_logged_in?
      # valid activation token
      get edit_account_activation_path(user.activation_token, email: user.email)
      assert user.reload.activated?
      follow_redirect!
      assert_template 'users/show'
      assert is_logged_in?

      log_out
    end
  end
end
