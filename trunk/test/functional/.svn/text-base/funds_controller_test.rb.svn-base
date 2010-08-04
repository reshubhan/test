require 'test_helper'

class FundsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:funds)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_fund
    assert_difference('Fund.count') do
      post :create, :fund => { }
    end

    assert_redirected_to fund_path(assigns(:fund))
  end

  def test_should_show_fund
    get :show, :id => funds(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => funds(:one).id
    assert_response :success
  end

  def test_should_update_fund
    put :update, :id => funds(:one).id, :fund => { }
    assert_redirected_to fund_path(assigns(:fund))
  end

  def test_should_destroy_fund
    assert_difference('Fund.count', -1) do
      delete :destroy, :id => funds(:one).id
    end

    assert_redirected_to funds_path
  end
end
