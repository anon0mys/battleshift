require 'rails_helper'

describe TurnProcessor do
  describe '#run!' do
    describe 'against a computer' do
      it 'runs a turn' do
        user_1 = create(:user)
        game = create(:game, player_1: user_1)

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
        game = create(:game, player_1: user_1, player_2: user_2)

        processor = TurnProcessor.new(game, 'A1', user_1)
        processor.run!

        expected_message = 'Your shot resulted in a Miss.'

        expect(processor.message).to eq(expected_message)
      end
    end
  end

  describe 'user hits a ship' do
    context 'enough to cause damage equal to length' do
      it 'and sinks the ship' do
        user_1 = create(:user)
        board = Board.new(4)
        ship = Ship.new(2, 'A1', 'A2')
        ShipPlacer.new(board, ship).run
        game = create(:game, player_1: user_1, player_2_board: board)

        expect(game.player_2_board.locate_space('A1').ship.is_sunk?).to_not be true

        TurnProcessor.new(game, 'A1', user_1).run!
        processor = TurnProcessor.new(game, 'A2', user_1)
        processor.run!

        expect(game.player_2_board.locate_space('A1').ship.is_sunk?).to be true
        expect(processor.message).to include('Battleship sunk.')
      end
    end

    context 'and sinks the last ship' do
      it 'and the game ends' do
        user_1 = create(:user)
        board = Board.new(4)
        ship = Ship.new(2, 'A1', 'A2')
        ShipPlacer.new(board, ship).run
        game = create(:game, player_1: user_1, player_2_board: board)

        expect(game.player_2_board.locate_space('A1').ship.is_sunk?).to_not be true

        TurnProcessor.new(game, 'A1', user_1).run!
        processor = TurnProcessor.new(game, 'A2', user_1)
        processor.run!

        expect(game.player_2_board.locate_space('A1').ship.is_sunk?).to be true
        expect(processor.message).to include('Battleship sunk.')
        expect(processor.message).to include('Game over.')
      end
    end
  end

  describe 'user fires at a ship' do
    context 'after the game is over' do
      it 'and the shot is not allowed' do
        user_1 = create(:user)
        board = Board.new(4)
        ship = Ship.new(2, 'A1', 'A2')
        ShipPlacer.new(board, ship).run
        game = create(:game, player_1: user_1, player_2_board: board)

        expect(game.player_2_board.locate_space('A1').ship.is_sunk?).to_not be true

        TurnProcessor.new(game, 'A1', user_1).run!
        processor = TurnProcessor.new(game, 'A2', user_1)
        processor.run!

        expect(game.player_2_board.locate_space('A1').ship.is_sunk?).to be true
        expect(processor.message).to include('Battleship sunk.')
        expect(processor.message).to include('Game over.')

        failed_processor = TurnProcessor.new(game, 'A3', user_1)
        failed_processor.run!

        expect(failed_processor.message).to include('Invalid move. Game over.')
      end
    end
  end
end
