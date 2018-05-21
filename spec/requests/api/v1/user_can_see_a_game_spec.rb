require 'rails_helper'

describe 'GET /api/v1/games/1' do
  context 'with an existing game' do
    it 'returns a game with boards' do
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      sm_ship = Ship.new(2, 'A1', 'A2')
      md_ship = Ship.new(3, 'B1', 'D1')

      ShipPlacer.new(player_1_board, sm_ship).run
      ShipPlacer.new(player_1_board, md_ship).run
      ShipPlacer.new(player_2_board, sm_ship.dup).run
      ShipPlacer.new(player_2_board, md_ship.dup).run

      game_attrs = { player_1_board: player_1_board,
                     player_2_board: player_2_board,
                     player_1_turns: 0,
                     player_2_turns: 0,
                     current_turn: 'player_1' }

      game = Game.new(game_attrs)
      game.save!

      get "/api/v1/games/#{game.id}"

      actual  = JSON.parse(response.body, symbolize_names: true)
      expected = Game.last

      expect(response).to be_success
      expect(actual[:id]).to eq(expected.id)
      expect(actual[:current_turn]).to eq(expected.current_turn)
      expect(actual[:player_1_board][:rows].count).to eq(4)
      expect(actual[:player_2_board][:rows].count).to eq(4)
      expect(actual[:player_1_board][:rows][0][:name]).to eq("row_a")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:status]).to eq("Not Attacked")
    end
  end

  describe 'with no game' do
    it 'returns a 400' do
      get "/api/v1/games/1"

      expect(response.status).to be(400)
    end
  end
end
