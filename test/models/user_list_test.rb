require 'test_helper'

class UserList < ActiveSupport::TestCase
  setup do
    @user_one = User.new first_name: 'James', last_name: 'Bond'
    @user_two = User.new first_name: 'John', last_name: 'Galt'
    @storage = [@user_one, @user_two].to_json
  end

  test '#all' do
    users = UserList.new(@storage).all
    assert_includes users, @user_one
    assert_includes users, @user_two
  end

  test '#delete_all' do
    users = UserList.new(@storage)
    users.delete_all
    assert_nil @storage
  end

  test '#add' do
    user_params = { first_name: 'Frank', last_name: 'Ford' }
    UserList.new(@storage).add(user_params)
    assert_includes @storage, user_params[:first_name]
  end

  test '#find' do
    user = UserList.new(@storage).find(1)
    assert_same @user_one, user
  end

  test '#update' do
    user_params = { first_name: '', last_name: 'Ford' }
    UserList.new(@storage).update(1, user_params)
    assert_includes @storage, user_params[:last_name]
  end

  test '#destroy' do
    UserList.new(@storage).destroy(1)
    assert_not_includes @storage, @user_one[:first_name]
  end
end
