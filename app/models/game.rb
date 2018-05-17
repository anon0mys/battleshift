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
    else
      player_2
    end
  end
end
