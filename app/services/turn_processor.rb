class TurnProcessor
  attr_reader :status
  def initialize(game, target, user)
    @game   = game
    @target = target
    @player = PlayerDecorator.new(user, game.active_board)
    @messages = []
    @status = 200
  end

  def run!
    begin
      check_turn
      attack_opponent
      set_turn
      game.save!
    rescue ApiExceptions::InvalidAttack => e
      @messages << e.message
      @status = 400
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target, :player

  def attack_opponent
    result = Shooter.fire!(board: game.target_board, target: target)
    @messages << "Your shot resulted in a #{result}."
  end

  def ai_attack_back
    result = AiSpaceSelector.new(@player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def check_turn
    unless @player.id == @game.active_player.id
      raise ApiExceptions::InvalidAttack.new('Invalid move. It\'s your opponent\'s turn', 400)
    end
  end

  def set_turn
    if @game.player_2.name == 'Artie'
      ai_attack_back
    else
      game.switch_turn
    end
  end
end
