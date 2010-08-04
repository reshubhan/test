require 'test_helper'

class ManagersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:managers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_manager
    assert_difference('Manager.count') do
      post :create, :manager => { }
    end

    assert_redirected_to manager_path(assigns(:manager))
  end

  def test_should_show_manager
    get :show, :id => managers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => managers(:one).id
    assert_response :success
  end

  def test_should_update_manager
    put :update, :id => managers(:one).id, :manager => { }
    assert_redirected_to manager_path(assigns(:manager))
  end

  def test_should_destroy_manager
    assert_difference('Manager.count', -1) do
      delete :destroy, :id => managers(:one).id
    end

    assert_redirected_to managers_path
  end
end
