class Game

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

  def log(item)
    time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    record = "#{time} :: #{item}"
    log = game_log || []
    log << record
    @store.set(personal('log'), log)
  end

  def game_log
    @store.get(personal('log'))
  end

  private

  def personal(key)
    "#{@base_key}/#{key}"
  end

end

