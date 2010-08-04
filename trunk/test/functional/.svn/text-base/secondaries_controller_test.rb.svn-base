require 'test_helper'

class SecondariesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:secondaries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_secondary
    assert_difference('Secondary.count') do
      post :create, :secondary => { }
    end

    assert_redirected_to secondary_path(assigns(:secondary))
  end

  def test_should_show_secondary
    get :show, :id => secondaries(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => secondaries(:one).id
    assert_response :success
  end

  def test_should_update_secondary
    put :update, :id => secondaries(:one).id, :secondary => { }
    assert_redirected_to secondary_path(assigns(:secondary))
  end

  def test_should_destroy_secondary
    assert_difference('Secondary.count', -1) do
      delete :destroy, :id => secondaries(:one).id
    end

    assert_redirected_to secondaries_path
  end
end
