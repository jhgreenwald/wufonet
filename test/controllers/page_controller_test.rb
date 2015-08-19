require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get member" do
    get :member
    assert_response :success
  end

  test "should get roster" do
    get :roster
    assert_response :success
  end

  test "should get event" do
    get :event
    assert_response :success
  end

end
