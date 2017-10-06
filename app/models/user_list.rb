class UserList
  def initialize(storage)
    @storage = storage
    @users = parse
  end

  def ids
    all.map(&:id)
  end

  def generate_new_id
    ids.max.to_i + 1
  end

  def add(user)
    @users << user
    save
  end

  def find(id)
    id   = id.to_i
    user = @users.find { |u| u.id == id }
  end

  def save
    @storage.write @users
    true
  end

  def update(user)
    user_index = @users.index find(user.id)
    @users[user_index] = user
    save
  end

  def destroy(id)
    @users.delete find(id)
    save
  end

  def all
    @users
  end

  delegate :count, to: :all

  def clear
    @storage.write nil
  end

  private

  def parse
    @storage.read.inject([]) { |rez, user| rez << User.new(user.symbolize_keys) }
  end
end
