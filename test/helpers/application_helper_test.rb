require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "full title helper" do
    title = "Help"
    assert_equal full_title,        @base_title
    assert_equal full_title(title), "#{title} | #{@base_title}"
  end
end
