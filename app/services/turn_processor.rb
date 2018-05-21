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
    begin
      raise ApiExceptions::GameOver.new('Invalid move. Game over.') unless @game.winner.nil?
      board = game.target_board
      result = Shooter.fire!(board: board, target: target)
      @messages << "Your shot resulted in a #{result}."
      if result == 'Hit' && board.locate_space(@target).ship.is_sunk?
        @messages << 'Battleship sunk.'
        game_end
      end
    rescue ApiExceptions::GameOver => e
      @messages << e.message
      @status = 400
    end
  end

  def game_end
    unless ships_sunk.include?(false)
      @messages << 'Game over.'
      @game.winner = @game.active_player.email
      @game.save!
    end
  end

  def ships_sunk
    all_occupied_spaces.map { |space| space.ship.is_sunk? }
  end

  def all_occupied_spaces
    spaces.select do |space|
      space.occupied?
    end
  end

  def spaces
    @game.target_board.board.flatten.map do |hash|
      hash.values
    end.flatten
  end

  def ai_attack_back
    result = AiSpaceSelector.new(@player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
  end

  def check_turn
    unless @player.id == @game.active_player.id
      raise ApiExceptions::InvalidAttack.new('Invalid move. It\'s your opponent\'s turn')
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
