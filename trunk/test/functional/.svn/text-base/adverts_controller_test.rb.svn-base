require 'test_helper'

class AdvertsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adverts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create advert" do
    assert_difference('Advert.count') do
      post :create, :advert => { }
    end

    assert_redirected_to advert_path(assigns(:advert))
  end

  test "should show advert" do
    get :show, :id => adverts(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => adverts(:one).id
    assert_response :success
  end

  test "should update advert" do
    put :update, :id => adverts(:one).id, :advert => { }
    assert_redirected_to advert_path(assigns(:advert))
  end

  test "should destroy advert" do
    assert_difference('Advert.count', -1) do
      delete :destroy, :id => adverts(:one).id
    end

    assert_redirected_to adverts_path
  end
end
