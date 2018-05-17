require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it { should validate_presence_of :player_1_board }
    it { should validate_presence_of :player_2_board }
  end

  describe 'instance methods' do
    it 'should find #active_player' do
      user_1 = create(:user)
      user_2 = create(:user)
      game = create(:game, player_1: user_1.id, player_2: user_2.id)

      expect(game.active_player).to eq(user_1.id)

      game.current_turn = 'player_2'

      expect(game.active_player).to_not eq(user_1.id)
      expect(game.active_player).to eq(user_2.id)
    end
  end
end
