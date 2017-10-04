require 'test_helper'

class StorageTest < ActiveSupport::TestCase
  setup do
    @tmp_storage = { users: "[{\"id\":1,\"first_name\":\"James\",\"last_name\":\"Broun\"}]" }
    @storage = Storage.new(@tmp_storage, UserSerializer.new)
  end

  test '#read' do
    rez = @storage.read
    assert rez.is_a? Array
    assert rez.first.is_a? Hash
    assert_equal rez.first['last_name'], 'Broun'
  end

  test '#write' do
    user_one = User.new id: 1, first_name: 'James', last_name: 'Bond'
    user_two = User.new id: 2, first_name: 'John', last_name: 'Galt'
    collection = [user_one, user_two]
    prev_tmp_storage = @tmp_storage.clone
    @storage.write collection

    assert_not_equal prev_tmp_storage, @tmp_storage
    assert_includes @tmp_storage[:users], user_one.first_name
    assert_includes @tmp_storage[:users], user_one.last_name
  end
end
