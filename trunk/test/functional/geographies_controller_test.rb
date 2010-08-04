require 'test_helper'

class GeographiesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:geographies)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_geography
    assert_difference('Geography.count') do
      post :create, :geography => { }
    end

    assert_redirected_to geography_path(assigns(:geography))
  end

  def test_should_show_geography
    get :show, :id => geographies(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => geographies(:one).id
    assert_response :success
  end

  def test_should_update_geography
    put :update, :id => geographies(:one).id, :geography => { }
    assert_redirected_to geography_path(assigns(:geography))
  end

  def test_should_destroy_geography
    assert_difference('Geography.count', -1) do
      delete :destroy, :id => geographies(:one).id
    end

    assert_redirected_to geographies_path
  end
end
