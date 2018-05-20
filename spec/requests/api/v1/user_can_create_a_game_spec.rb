require 'rails_helper'

describe 'POST /api/v1/games' do
  it 'creates a new game' do
    challenger = create(:user)
    defender = create(:user)

    post '/api/v1/games', params: { opponent_email: defender.email }, headers: { 'X-API-Key' => challenger.api_key }

    game_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(game_response[:id]).to eq(1)
    binding.pry
  end
end
