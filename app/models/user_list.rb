class UserList
  def initialize(storage)
    @storage = storage
    parse
  end

  def generate_new_id
    @users.last.id + 1
  end

  def add(user)
    @users << user
    @storage.write @users
    true
  end

  def find(id)
    id   = id.to_i
    user = @users.find { |u| u.id == id }
    @users[@users.index(user)]
  end

  def save
    @storage.write @users
    true
  end

  def destroy(id)
    @users.delete find(id)
    save
  end

  def all
    @users
  end

  delegate :count, to: :all

  def rollback
    parse
    self
  end

  def delete_all
    @storage.write nil
  end

  private

  def parse
    return [] unless @storage
    @users = @storage.read.inject([]) { |rez, user| rez << User.new(user.symbolize_keys) }
  end
end
