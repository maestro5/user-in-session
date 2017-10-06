class UserSerializer
  def parse_collection(collection)
    return unless collection
    JSON.parse(collection)
  end

  def serialize(collection)
    collection.to_json(except: 'errors')
  end
end
