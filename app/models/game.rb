class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ['player_1', 'player_2']
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  def active_player
    if current_turn == 'player_1'
      player_1
    elsif current_turn == 'player_2'
      player_2
    end
  end

  def active_board
    if current_turn == 'player_1'
      player_1_board
    elsif current_turn == 'player_2'
      player_2_board
    end
  end

  def target_board
    if current_turn == 'player_1'
      player_2_board
    elsif current_turn == 'player_2'
      player_1_board
    end
  end

  def switch_turn
    if current_turn == 'player_1'
      self.current_turn = 'player_2'
    elsif current_turn == 'player_2'
      self.current_turn = 'player_1'
    end
  end
end
