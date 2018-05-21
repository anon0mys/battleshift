require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it { should validate_presence_of :player_1_board }
    it { should validate_presence_of :player_2_board }
  end

  describe 'instance methods' do
    it 'should assign variables for #turn_setup' do
      user_1 = create(:user)
      user_2 = create(:user)
      game = create(:game,
                    player_1: user_1,
                    player_2: user_2,
                    player_1_board: 'Player 1 Board',
                    player_2_board: 'Player 2 Board')

      expect(game.active_player).to eq(user_1)

      game.current_turn = 'player_2'

      expect(game.active_player).to_not eq(user_1)
      expect(game.active_player).to eq(user_2)
    end

    it 'should find #active_player_board' do
      user_1 = create(:user)
      user_2 = create(:user)
      game = create(:game,
                    player_1: user_1,
                    player_2: user_2,
                    player_1_board: 'Player 1 Board',
                    player_2_board: 'Player 2 Board')

      expect(game.active_player).to eq(user_1)
      expect(game.active_board).to eq('Player 1 Board')

      game.current_turn = 'player_2'

      expect(game.active_player).to eq(user_2)
      expect(game.active_board).to eq('Player 2 Board')
    end

    it 'should find #target_board' do
      user_1 = create(:user)
      user_2 = create(:user)
      game = create(:game,
                    player_1: user_1,
                    player_2: user_2,
                    player_1_board: 'Player 1 Board',
                    player_2_board: 'Player 2 Board')

      expect(game.active_player).to eq(user_1)
      expect(game.target_board).to eq('Player 2 Board')

      game.current_turn = 'player_2'

      expect(game.active_player).to eq(user_2)
      expect(game.target_board).to eq('Player 1 Board')
    end
  end
end
