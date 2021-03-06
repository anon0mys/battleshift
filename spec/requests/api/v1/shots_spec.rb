require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    context 'playing against the computer' do
      let(:user_1) { create(:user) }
      let(:player_1_board)   { Board.new(4) }
      let(:player_2_board)   { Board.new(4) }
      let(:sm_ship) { Ship.new(2, 'A1', 'A2') }
      let(:game)    {
        create(:game,
          player_1: user_1,
          player_1_board: player_1_board,
          player_2_board: player_2_board
        )
      }

      it "updates the message and board with a hit" do
        allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")
        ShipPlacer.new(player_2_board, sm_ship).run

        headers = {
          'CONTENT_TYPE' => 'application/json',
          'X-API-Key' => user_1.api_key
        }
        json_payload = {target: "A1"}.to_json

        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        expect(response).to be_success

        game = JSON.parse(response.body, symbolize_names: true)

        expected_messages = "Your shot resulted in a Hit. The computer's shot resulted in a Miss."
        player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


        expect(game[:message]).to eq expected_messages
        expect(player_2_targeted_space).to eq("Hit")
      end

      it "updates the message and board with a miss" do
        allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")

        headers = {
          'CONTENT_TYPE' => 'application/json',
          'X-API-Key' => user_1.api_key
        }
        json_payload = {target: "A1"}.to_json

        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        expect(response).to be_success

        game = JSON.parse(response.body, symbolize_names: true)

        expected_messages = "Your shot resulted in a Miss. The computer's shot resulted in a Miss."
        player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


        expect(game[:message]).to eq expected_messages
        expect(player_2_targeted_space).to eq("Miss")
      end

      it "updates the message but not the board with invalid coordinates" do
        player_1_board = Board.new(1)
        player_2_board = Board.new(1)
        game = create(:game, player_1: user_1, player_1_board: player_1_board, player_2_board: player_2_board)

        headers = {
          'CONTENT_TYPE' => 'application/json',
          'X-API-Key' => user_1.api_key
        }
        json_payload = {target: "B1"}.to_json
        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        game = JSON.parse(response.body, symbolize_names: true)
        expect(game[:message]).to eq "Invalid coordinates."
      end
    end

    context 'playing against another user' do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }
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

      it 'updates the message and board with a hit' do
        ShipPlacer.new(player_2_board, sm_ship).run

        headers = {
          'CONTENT_TYPE' => 'application/json',
          'X-API-Key' => user_1.api_key
          }
        json_payload = {target: "A1"}.to_json

        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        expect(response).to be_success

        game = JSON.parse(response.body, symbolize_names: true)

        expected_messages = "Your shot resulted in a Hit."
        player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


        expect(game[:message]).to eq expected_messages
        expect(player_2_targeted_space).to eq("Hit")
        expect(game[:current_turn]).to eq('player_2')
      end

      it 'does not allow a user to shoot on opponent turn' do
        ShipPlacer.new(player_2_board, sm_ship).run

        headers = {
         'CONTENT_TYPE' => 'application/json',
         'X-API-Key' => user_2.api_key
         }

        json_payload = {target: "A1"}.to_json

        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        game = JSON.parse(response.body, symbolize_names: true)

        expected_messages = "Invalid move. It's your opponent's turn"
      end

      it 'allows player 2 to shoot at player 1 board' do
        new_player_1_board = Board.new(4)

        ShipPlacer.new(new_player_1_board, sm_ship).run

        game = create(:game,
          player_1: user_1,
          player_2: user_2,
          player_1_board: new_player_1_board,
          player_2_board: player_2_board,
          current_turn: 'player_2'
        )

        headers = {
         'CONTENT_TYPE' => 'application/json',
         'X-API-Key' => user_2.api_key
         }

        json_payload = {target: "A1"}.to_json

        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        expect(response).to be_success

        game = JSON.parse(response.body, symbolize_names: true)

        expected_messages = "Your shot resulted in a Hit."
        player_1_targeted_space = game[:player_1_board][:rows].first[:data].first[:status]


        expect(game[:message]).to eq expected_messages
        expect(player_1_targeted_space).to eq("Hit")
      end

      it 'does not allow invalid api keys' do
        headers = {
          'CONTENT_TYPE' => 'application/json',
          'X-API-Key' => 'NotARealAPIKey'
          }

        json_payload = {target: "A1"}.to_json

        post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

        expect(@response.status).to eq(401)
        response = JSON.parse(@response.body, symbolize_names: true)

        expect(response[:message]).to eq("Unauthorized")
      end
    end
  end
end
