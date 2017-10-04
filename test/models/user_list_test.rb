require 'test_helper'

class UserListTest < ActiveSupport::TestCase
  setup do
    @user_one   = User.new id: 5, first_name: 'James', last_name: 'Bond'
    @user_two   = User.new id: 6, first_name: 'John', last_name: 'Galt'
    @user_three = User.new id: 9, first_name: 'Harry', last_name: 'Potter'
    @tmp_storage = {}
    storage  = Storage.new(@tmp_storage, UserSerializer.new)
    @subject = UserList.new(storage)
    @subject.add @user_one
    @subject.add @user_two
  end

  test '#generate_new_id' do
    assert_equal 7, @subject.generate_new_id
  end

  test '#add' do
    assert @subject.add(@user_three)
    assert_includes @subject.all, @user_three
  end

  test '#find' do
    assert_equal @subject.find(5), @user_one
  end

  test '#save' do
    first_name = 'Jaklin'
    @subject.add @user_three
    @subject.find(9).first_name = first_name
    assert @subject.save
    assert_includes @tmp_storage[:users], first_name
  end

  test '#destroy' do
    @subject.destroy(5)
    assert_not_includes @subject.all, @user_one
  end

  test '#all' do
    assert_includes @subject.all, @user_one
    assert_includes @subject.all, @user_two
  end

  test '#count' do
    assert_equal @subject.count, 2
  end

  test '#rollback' do
    first_name = 'Jaklin'
    @subject.find(5).first_name = first_name
    @subject.rollback
    assert_not_equal @subject.find(5).first_name, first_name
  end

  test '#delete_all' do
    @subject.delete_all
    assert @subject.all, "null"
  end

  def teardown
    @subject.delete_all
  end
end
