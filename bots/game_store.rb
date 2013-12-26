class GameStore

  def initialize(base_key, store)
    @base_key = base_key
    @store = store
  end

  def []=(key, value)
    @store.set("#{@base_key}/#{key}", value)
  end

  def [](key)
    @store.get("#{@base_key}/#{key}")
  end

end

