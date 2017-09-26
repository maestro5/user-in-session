class UserSerializer
  def self.parse_collection(collection)
    collection = JSON.parse(collection)    
    collection.inject([]) { |rez, user| rez << User.new(user.symbolize_keys) }
  end

  def initialize(user)
    @user = user
  end

  def to_h
    {id: @user.id, first_name: @user.first_name, last_name: @user.last_name}
  end
end
