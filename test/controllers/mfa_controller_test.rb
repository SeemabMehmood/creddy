require "test_helper"

class MfaControllerTest < ActionDispatch::IntegrationTest
  test "should get enable" do
    get mfa_enable_url
    assert_response :success
  end

  test "should get disable" do
    get mfa_disable_url
    assert_response :success
  end

  test "should get verify" do
    get mfa_verify_url
    assert_response :success
  end
end
