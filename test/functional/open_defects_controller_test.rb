require 'test_helper'

class OpenDefectsControllerTest < ActionController::TestCase
  setup do
    @open_defect = open_defects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:open_defects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create open_defect" do
    assert_difference('OpenDefect.count') do
      post :create, open_defect: @open_defect.attributes
    end

    assert_redirected_to open_defect_path(assigns(:open_defect))
  end

  test "should show open_defect" do
    get :show, id: @open_defect
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @open_defect
    assert_response :success
  end

  test "should update open_defect" do
    put :update, id: @open_defect, open_defect: @open_defect.attributes
    assert_redirected_to open_defect_path(assigns(:open_defect))
  end

  test "should destroy open_defect" do
    assert_difference('OpenDefect.count', -1) do
      delete :destroy, id: @open_defect
    end

    assert_redirected_to open_defects_path
  end
end
