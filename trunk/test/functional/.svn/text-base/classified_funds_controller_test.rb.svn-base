require 'test_helper'

class ClassifiedFundsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:classified_funds)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_classified_fund
    assert_difference('ClassifiedFund.count') do
      post :create, :classified_fund => { }
    end

    assert_redirected_to classified_fund_path(assigns(:classified_fund))
  end

  def test_should_show_classified_fund
    get :show, :id => classified_funds(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => classified_funds(:one).id
    assert_response :success
  end

  def test_should_update_classified_fund
    put :update, :id => classified_funds(:one).id, :classified_fund => { }
    assert_redirected_to classified_fund_path(assigns(:classified_fund))
  end

  def test_should_destroy_classified_fund
    assert_difference('ClassifiedFund.count', -1) do
      delete :destroy, :id => classified_funds(:one).id
    end

    assert_redirected_to classified_funds_path
  end
end
