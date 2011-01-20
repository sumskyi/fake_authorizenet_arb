require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Subscription.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Subscription.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Subscription.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to subscription_url(assigns(:subscription))
  end

  def test_edit
    get :edit, :id => Subscription.first
    assert_template 'edit'
  end

  def test_update_invalid
    Subscription.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Subscription.first
    assert_template 'edit'
  end

  def test_update_valid
    Subscription.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Subscription.first
    assert_redirected_to subscription_url(assigns(:subscription))
  end

  def test_destroy
    subscription = Subscription.first
    delete :destroy, :id => subscription
    assert_redirected_to subscriptions_url
    assert !Subscription.exists?(subscription.id)
  end
end
