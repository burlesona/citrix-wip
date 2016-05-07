require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:regular)
  end

  test "should get index for admin" do
    adm = CurrentUser.new(users(:admin))
    @controller.stub(:current_user,adm) do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {
        email: 'new@example.com',
        username: 'foo',
        first_name: 'foo',
        last_name: 'bar',
        password: 'secret',
        password_confirmation: 'secret',
      }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    @controller.stub(:current_user,@user) do
      get :show, id: @user
      assert_response :success
    end
  end

  test "should get edit" do
    @controller.stub(:current_user,@user) do
      get :edit, id: @user
      assert_response :success
    end
  end

  test "should update user" do
    @controller.stub(:current_user,@user) do
      patch :update, id: @user, user: {
        first_name: 'foo',
        last_name: 'bar'
      }
      assert_redirected_to user_path(assigns(:user))
    end
  end

  test "should destroy user" do
    @controller.stub(:current_user,@user) do
      assert_difference('User.count', -1) do
        delete :destroy, id: @user
      end
      assert_redirected_to users_path
    end
  end
end
