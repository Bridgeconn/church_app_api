require 'test_helper'

class ChurchAppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @church_app = church_apps(:one)
  end

  test "should get index" do
    get church_apps_url
    assert_response :success
  end

  test "should get new" do
    get new_church_app_url
    assert_response :success
  end

  test "should create church_app" do
    assert_difference('ChurchApp.count') do
      post church_apps_url, params: { church_app: {  } }
    end

    assert_redirected_to church_app_url(ChurchApp.last)
  end

  test "should show church_app" do
    get church_app_url(@church_app)
    assert_response :success
  end

  test "should get edit" do
    get edit_church_app_url(@church_app)
    assert_response :success
  end

  test "should update church_app" do
    patch church_app_url(@church_app), params: { church_app: {  } }
    assert_redirected_to church_app_url(@church_app)
  end

  test "should destroy church_app" do
    assert_difference('ChurchApp.count', -1) do
      delete church_app_url(@church_app)
    end

    assert_redirected_to church_apps_url
  end
end
