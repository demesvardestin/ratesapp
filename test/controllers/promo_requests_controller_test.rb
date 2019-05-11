require 'test_helper'

class PromoRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get promo_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get promo_requests_create_url
    assert_response :success
  end

  test "should get show" do
    get promo_requests_show_url
    assert_response :success
  end

end
