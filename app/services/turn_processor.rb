class TurnProcessor
  def initialize(game, target, user)
    @game   = game
    @target = target
    @player = PlayerDecorator.new(user, game.player_1_board)
    @messages = []
  end

  def run!
    begin
      check_turn
      attack_opponent
      ai_attack_back if @game.player_2.nil?
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target, :player

  def attack_opponent
    result = Shooter.fire!(board: game.player_2_board, target: target)
    @messages << "Your shot resulted in a #{result}."
    game.player_1_turns += 1
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def check_turn
    unless @player.id == @game.active_player
      raise InvalidAttack.new('Invalid move. It\'s your opponent\'s turn')
    end
  end
end
