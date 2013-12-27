require 'json'

class GameLog

  def initialize(game)
    @game = game
  end

  def clear
    @game['log'] = [].to_json
  end

  def record(item)
    time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    record = "#{time} :: #{item}"
    log = all_items
    log << record
    @game['log'] = log.to_json
  end

  def all_items
    log = @game['log']
    if log
      JSON.parse(log)
    else
      []
    end
  end

end

