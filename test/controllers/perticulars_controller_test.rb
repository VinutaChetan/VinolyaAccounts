require 'test_helper'

class PerticularsControllerTest < ActionController::TestCase
  setup do
    @perticular = perticulars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:perticulars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create perticular" do
    assert_difference('Perticular.count') do
      post :create, perticular: { name: @perticular.name }
    end

    assert_redirected_to perticular_path(assigns(:perticular))
  end

  test "should show perticular" do
    get :show, id: @perticular
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @perticular
    assert_response :success
  end

  test "should update perticular" do
    patch :update, id: @perticular, perticular: { name: @perticular.name }
    assert_redirected_to perticular_path(assigns(:perticular))
  end

  test "should destroy perticular" do
    assert_difference('Perticular.count', -1) do
      delete :destroy, id: @perticular
    end

    assert_redirected_to perticulars_path
  end
end
