require File.dirname(__FILE__) + '/../test_helper'

class SlideshowsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:slideshows)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_slideshow
    assert_difference('Slideshow.count') do
      post :create, :slideshow => { }
    end

    assert_redirected_to slideshow_path(assigns(:slideshow))
  end

  def test_should_show_slideshow
    get :show, :id => slideshows(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => slideshows(:one).id
    assert_response :success
  end

  def test_should_update_slideshow
    put :update, :id => slideshows(:one).id, :slideshow => { }
    assert_redirected_to slideshow_path(assigns(:slideshow))
  end

  def test_should_destroy_slideshow
    assert_difference('Slideshow.count', -1) do
      delete :destroy, :id => slideshows(:one).id
    end

    assert_redirected_to slideshows_path
  end
end
