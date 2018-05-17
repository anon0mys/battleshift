require 'rails_helper'

describe TurnProcessor do
  describe '#run!' do
    describe 'against a computer' do
      it 'runs a turn' do
        user_1 = create(:user)
        game = create(:game, player_1: user_1.id)

        processor = TurnProcessor.new(game, 'A1', user_1)
        processor.run!

        expected_message = 'Your shot resulted in a Miss. The computer\'s shot resulted in a Miss.'

        expect(processor.message).to eq(expected_message)
      end
    end

    describe 'against a player' do
      it 'runs a turn' do
        user_1 = create(:user)
        user_2 = create(:user)
        game = create(:game, player_1: user_1.id, player_2: user_2.id)

        processor = TurnProcessor.new(game, 'A1', user_1)
        processor.run!

        expected_message = 'Your shot resulted in a Miss.'

        expect(processor.message).to eq(expected_message)
      end
    end
  end
end
