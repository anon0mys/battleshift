class Game < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  attr_accessor :messages

  enum current_turn: ['player_1', 'player_2']
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  def determine_player_board(player)
    if player_1.id == player.id
      player_1_board
    elsif player_2.id == player.id
      player_2_board
    end
  end

  def active_player
    self.send(current_turn)
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
