require 'test_helper'

class PurchasedItemControllerTest < ActionController::TestCase
  test "should get item_id:integer" do
    get :item_id:integer
    assert_response :success
  end

  test "should get purchase_id:integer" do
    get :purchase_id:integer
    assert_response :success
  end

  test "should get buyer_id:integer" do
    get :buyer_id:integer
    assert_response :success
  end

  test "should get redeemer_id:integer" do
    get :redeemer_id:integer
    assert_response :success
  end

  test "should get is_redeemed:boolean" do
    get :is_redeemed:boolean
    assert_response :success
  end

end
