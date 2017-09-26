require 'test_helper'

class UserSerializer < ActiveSupport::TestCase
  setup do
    @user_one = User.new first_name: 'James', last_name: 'Bond'
    @user_two = User.new first_name: 'John', last_name: 'Galt'
  end

  test '.parse_collection' do
    collection = [@user_one, @user_two].to_json
    users = UserSerializer.parse_collection(collection)
    assert_includes users, @user_one
    assert_includes users, @user_two
  end

  test '#to_h' do
    user_hash = 
      {
        id: @user_one.id,
        first_name: @user_one.first_name,
        last_name: @user_one.last_name
      }
    binding.pry
    assert_equal UserSerializer.new(@user_one).to_h, user_hash
  end
end
