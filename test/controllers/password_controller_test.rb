require "test_helper"

class PasswordControllerTest < ActionDispatch::IntegrationTest
  test "should get forgot_password" do
    get password_forgot_password_url
    assert_response :success
  end
end
