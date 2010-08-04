require 'test_helper'

class WebinarsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:webinars)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_webinar
    assert_difference('Webinar.count') do
      post :create, :webinar => { }
    end

    assert_redirected_to webinar_path(assigns(:webinar))
  end

  def test_should_show_webinar
    get :show, :id => webinars(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => webinars(:one).id
    assert_response :success
  end

  def test_should_update_webinar
    put :update, :id => webinars(:one).id, :webinar => { }
    assert_redirected_to webinar_path(assigns(:webinar))
  end

  def test_should_destroy_webinar
    assert_difference('Webinar.count', -1) do
      delete :destroy, :id => webinars(:one).id
    end

    assert_redirected_to webinars_path
  end
end
