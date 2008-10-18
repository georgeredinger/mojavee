require 'test_helper'

class LinkcategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:linkcategories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_linkcategory
    assert_difference('Linkcategory.count') do
      post :create, :linkcategory => { }
    end

    assert_redirected_to linkcategory_path(assigns(:linkcategory))
  end

  def test_should_show_linkcategory
    get :show, :id => linkcategories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => linkcategories(:one).id
    assert_response :success
  end

  def test_should_update_linkcategory
    put :update, :id => linkcategories(:one).id, :linkcategory => { }
    assert_redirected_to linkcategory_path(assigns(:linkcategory))
  end

  def test_should_destroy_linkcategory
    assert_difference('Linkcategory.count', -1) do
      delete :destroy, :id => linkcategories(:one).id
    end

    assert_redirected_to linkcategories_path
  end
end
