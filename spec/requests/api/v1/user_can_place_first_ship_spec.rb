require 'rails_helper'

describe 'user places ships' do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }
  let(:not_player) {create(:user)}
  let(:game) { create(:game,
               player_1: player_1.id,
               player_2: player_2.id)
  }

  scenario 'works' do
    headers = { 'X-API-Key' => player_1.api_key,
                'CONTENT_TYPE' => 'application/json' }
    ship_json = { ship_size: 3,
                start_space: 'A1',
                end_space: 'A3' }.to_json

    post "/api/v1/games/#{game.id}/ships", params: ship_json, headers: headers
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(json[:message]).to include('Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.')
  end
  context 'does not work' do
    scenario 'when api key does not match either player' do
      headers = { 'X-API-Key' => not_player.api_key,
                  'CONTENT_TYPE' => 'application/json' }
      ship    = { ship_size: 3,
                  start_space: 'A1',
                  end_space: 'A3' }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship, headers: headers
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(json[:message]).to include('You are not a player in this game.')
    end
    scenario 'when ship is too big for board' do
      skip
      headers = { 'X-API-Key' => player_1.api_key,
                  'CONTENT_TYPE' => 'application/json' }
      ship_json = { ship_size: 5,
                    start_space: 'A1',
                    end_space: 'A5' }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_json, headers: headers

      expect(response.status).to eq(200)
      expect(response.body[:message]).to include()
    end
    scenario 'when coordinates do not exist' do
      skip
      headers = { 'X-API-Key' => player_1.api_key,
                  'CONTENT_TYPE' => 'application/json' }
      ship_json = { ship_size: 3,
                    start_space: 'A3',
                    end_space: 'A5' }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_json, headers: headers

      expect(response.status).to eq(200)
      expect(response.body[:message]).to include()
    end
    scenario 'when given coordinates do not line up' do
      skip
      headers = { 'X-API-Key' => player_1.api_key,
                  'CONTENT_TYPE' => 'application/json' }
      ship_json = { ship_size: 3,
                  start_space: 'A1',
                  end_space: 'B3' }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_json, headers: headers

      expect(response.status).to eq(200)
      expect(response.body[:message]).to include("Ship must be in either the same row or column.")
    end
  end
end
