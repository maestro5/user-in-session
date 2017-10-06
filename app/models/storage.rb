class Storage
  def initialize(storage, serializer)
    @storage    = storage
    @serializer = serializer
    raise 'Storage can\'t be nil, set the storage' unless @storage
  end

  # return users hash collection
  def read
    @serializer.parse_collection(@storage[:users]) || []
  end

  def write(collection)
    @storage[:users] = @serializer.serialize(collection)
  end
end
