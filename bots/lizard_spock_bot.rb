class LizardSpockBot

  def initialize(strategy, name, store)
    @strategy = strategy
    @name = name
    @store = store
  end

  def start(dynamite_count)
    @store.set("#{@name}/moves", '')
    @store.set("#{@name}/dynamite_left", dynamite_count)
    @store.set("#{@name}/oppo_last_move", '')
  end

  def move
    my_move = @strategy.move
    @store.set("#{@name}/my_last_move", my_move)
    if my_move == 'DYNAMITE'
      dyn = @store.get("#{@name}/dynamite_left").to_i - 1
      @store.set("#{@name}/dynamite_left", dyn)
    end
    history = @store.get("#{@name}/moves") || ''
    history = "#{history}{me: #{my_move}"
    @store.set("#{@name}/moves", history)
    my_move
  end

  def opponents_move(move)
    history = @store.get("#{@name}/moves") || ''
    history = "#{history}, him: #{move}}\n"
    @store.set("#{@name}/oppo_last_move", move)
    @store.set("#{@name}/moves", history)
  end

  def game_log
    @store.get("#{@name}/moves")
  end

end

