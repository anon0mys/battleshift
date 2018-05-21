require 'rails_helper'

describe 'user places second ship' do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }
  let(:not_player) {create(:user)}
  let(:game) { create(:game,
               player_1: player_1,
               player_2: player_2)
  }

  scenario 'works' do
    headers = { 'X-API-Key' => player_1.api_key,
                'CONTENT_TYPE' => 'application/json' }
    first_ship_json = { ship_size: 3,
                        start_space: 'A1',
                        end_space: 'A3' }.to_json

    post "/api/v1/games/#{game.id}/ships", params: first_ship_json, headers: headers

    second_ship_json = { ship_size: 2,
                         start_space: 'B1',
                         end_space: 'C1' }.to_json

    post "/api/v1/games/#{game.id}/ships", params: second_ship_json, headers: headers
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(json[:message]).to include('Successfully placed ship with a size of 2. You have 0 ship(s) to place.')
  end
end
