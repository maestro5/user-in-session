class UserList
  def initialize(storage)
    @storage = storage
    @users   = parse_storage
  end

  def all
    @users
  end

  def delete_all
    @storage = nil
  end

  def add(user_params)
    user = User.new(user_params)
    user.id = @users.count + 1
    @users << UserSerializer.new(user).to_h
    save
  end

  def find(id)
    id   = id.to_i
    user = @users.find { |user| user.id == id }
    @users[@users.index(user)]
  end

  def update(id, user_params)
    user = find(id)
    user.update(user_params)
    save
  end

  def destroy(id)
    @users.delete find(id)
    save
  end

  private

  def parse_storage
    @storage[:users] ? UserSerializer.parse_collection(@storage[:users]) : []
  end

  def save
    @storage[:users] = @users.to_json
  end
end
