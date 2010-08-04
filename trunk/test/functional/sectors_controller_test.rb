require 'test_helper'

class SectorsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sectors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sector
    assert_difference('Sector.count') do
      post :create, :sector => { }
    end

    assert_redirected_to sector_path(assigns(:sector))
  end

  def test_should_show_sector
    get :show, :id => sectors(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sectors(:one).id
    assert_response :success
  end

  def test_should_update_sector
    put :update, :id => sectors(:one).id, :sector => { }
    assert_redirected_to sector_path(assigns(:sector))
  end

  def test_should_destroy_sector
    assert_difference('Sector.count', -1) do
      delete :destroy, :id => sectors(:one).id
    end

    assert_redirected_to sectors_path
  end
end
