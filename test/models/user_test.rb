require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new id: 1, first_name: 'Frank', last_name: 'Sinatra'
  end

  test '#valid? when invalid' do
    user = User.new(id: 1, last_name: 'Sinatra')
    assert_not user.valid?
  end

  test '#valid? when valid' do
    assert @user.valid?
  end

  test '#update when param is empty' do
    user_params = { first_name: '', last_name: 'Ford' }
    assert_not @user.update(user_params)
    assert_includes @user.errors, 'First name can\'t be blank!'
  end

  test '#update' do
    user_params = { first_name: 'Frank', last_name: 'Ford' }
    user_prev = @user.clone
    assert @user.update(user_params)
    assert_not user_prev.to_s == @user.to_s
    assert @user.errors.empty?
  end

  test '#to_s' do
    assert @user.to_s == "#{@user.first_name} #{@user.last_name}"
  end
end
