require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:statistics)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_statistic
    assert_difference('Statistic.count') do
      post :create, :statistic => { }
    end

    assert_redirected_to statistic_path(assigns(:statistic))
  end

  def test_should_show_statistic
    get :show, :id => statistics(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => statistics(:one).id
    assert_response :success
  end

  def test_should_update_statistic
    put :update, :id => statistics(:one).id, :statistic => { }
    assert_redirected_to statistic_path(assigns(:statistic))
  end

  def test_should_destroy_statistic
    assert_difference('Statistic.count', -1) do
      delete :destroy, :id => statistics(:one).id
    end

    assert_redirected_to statistics_path
  end
end
