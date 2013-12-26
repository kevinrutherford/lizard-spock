class GameStore

  def initialize(base_key, store)
    @base_key = base_key
    @store = store
  end

  def []=(key, value)
    @store.set(personal(key), value)
  end

  def [](key)
    @store.get(personal(key))
  end

  private

  def personal(key)
    "#{@base_key}/#{key}"
  end

end

