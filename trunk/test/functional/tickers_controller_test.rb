require 'test_helper'

class TickersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tickers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_ticker
    assert_difference('Ticker.count') do
      post :create, :ticker => { }
    end

    assert_redirected_to ticker_path(assigns(:ticker))
  end

  def test_should_show_ticker
    get :show, :id => tickers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tickers(:one).id
    assert_response :success
  end

  def test_should_update_ticker
    put :update, :id => tickers(:one).id, :ticker => { }
    assert_redirected_to ticker_path(assigns(:ticker))
  end

  def test_should_destroy_ticker
    assert_difference('Ticker.count', -1) do
      delete :destroy, :id => tickers(:one).id
    end

    assert_redirected_to tickers_path
  end
end
