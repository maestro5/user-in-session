require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user_one = User.new(first_name: 'James', last_name: 'Bond')
    @user_two = User.new(first_name: 'Frank', last_name: 'Sinatra')
  end

  test '.all' do
    users = User.all
    assert_includes users, @user_one
    assert_includes users, @user_two
  end

  test '.find' do
    assert_equal @user_one, User.find(@user_one.id)
    assert_equal @user_two, User.find(@user_two.id)
  end

  test '#update' do
    user_params = { first_name: 'Frank', last_name: 'Ford' }
    user_two_prev = @user_two.clone
    @user_two.update(user_params)
    assert_not user_two_prev.to_s == @user_two.to_s
  end

  test '#update when param is empty' do
    user_params = { first_name: '', last_name: 'Ford' }
    user_two_prev = @user_two.clone
    @user_two.update(user_params)
    assert user_two_prev.first_name == @user_two.first_name
  end

  test '#destroy' do
    @user_one.destroy
    assert_not_includes User.all, @user_one
  end

  test '#to_s' do
    assert @user_one.to_s == "#{@user_one.first_name} #{@user_one.last_name}"
  end

  def teardown
    User.delete_all
  end
end
