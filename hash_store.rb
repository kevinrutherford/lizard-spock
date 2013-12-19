class HashStore

  def get(key)
    store[key]
  end

  def set(key, value)
    store[key] = value
  end

  private

  def store
    @store ||= {}
  end
end

