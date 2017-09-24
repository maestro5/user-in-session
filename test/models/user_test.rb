require 'test_helper'

class UserTest < ActiveSupport::TestCase
  @@user_one = User.new(first_name: 'James', last_name: 'Bond')
  @@user_two = User.new(first_name: 'Frank', last_name: 'Sinatra')

  test '.all' do
    users = User.all
    assert users.key?(@@user_one.id) && users.include?(@@user_two.id)
  end

  test '.find' do
    assert_equal @@user_one.to_s, User.find(@@user_one.id).values.join(' ')
    assert_equal @@user_two.to_s, User.find(@@user_two.id).values.join(' ')
  end

  test '.update' do
    user = User.new(first_name: 'John', last_name: 'Travolta')
    user_params = { first_name: 'John', last_name: 'Galt' }
    User.update(user.id, user_params)
    assert_not_equal user.to_s, User.find(user.id)
  end

  test '.destroy' do
    user = User.new(first_name: 'Harry', last_name: 'Potter')
    User.destroy(user.id)
    assert_not User.all.key? user.id
  end

  test '#to_s' do
    assert @@user_one.to_s == "#{@@user_one.first_name} #{@@user_one.last_name}"
  end
end
