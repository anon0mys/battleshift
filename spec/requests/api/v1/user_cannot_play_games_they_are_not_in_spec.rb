require 'rails_helper'

describe 'A user attempts an action' do
  context 'on a game they are not a player in' do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:user_3) { create(:user) }
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:sm_ship) { Ship.new(2, 'A1', 'A2') }
    let(:game)    {
      create(:game,
        player_1: user_1,
        player_2: user_2,
        player_1_board: player_1_board,
        player_2_board: player_2_board
      )
    }

    it "their request is refused" do
      ShipPlacer.new(player_2_board, sm_ship).run

      headers = {
        'CONTENT_TYPE' => 'application/json',
        'X-API-Key' => user_3.api_key
      }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response.status).to eq(200)

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "You are not a player in this game."
    end
  end
end
