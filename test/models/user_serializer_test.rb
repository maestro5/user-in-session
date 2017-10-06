require 'test_helper'

class UserSerializerTest < ActiveSupport::TestCase
  setup do
    @user_one = User.new id: 1, first_name: 'James', last_name: 'Bond'
    @user_two = User.new id: 2, first_name: 'John', last_name: 'Galt'
    @collection = [@user_one, @user_two]
    @serializer = UserSerializer.new
  end

  test '#parse_collection' do
    json_collectoin = @collection.to_json(except: 'errors')
    rez = @serializer.parse_collection(json_collectoin)
    assert rez.is_a? Array
    assert rez.first.is_a? Hash
    assert_equal rez.first['last_name'], @user_one.last_name
  end

  test '#serialize' do
    rez = @serializer.serialize(@collection)
    assert rez.is_a?(String)
    assert_includes rez, @user_one.first_name
    assert_includes rez, @user_two.last_name
    assert_not_includes rez, 'errors'
  end
end
