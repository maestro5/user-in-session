require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(first_name: 'Frank', last_name: 'Sinatra')
  end

  test '#update' do
    user_params = { first_name: 'Frank', last_name: 'Ford' }
    user_prev = @user.clone
    @user.update(user_params)
    assert_not user_prev.to_s == @user.to_s
  end
  
  test '#update when param is empty' do
    user_params = { first_name: '', last_name: 'Ford' }
    user_prev = @user.clone
    @user.update(user_params)
    assert user_prev.first_name == @user.first_name
  end

  test '#to_s' do
    assert @user.to_s == "#{@user.first_name} #{@user.last_name}"
  end
end
