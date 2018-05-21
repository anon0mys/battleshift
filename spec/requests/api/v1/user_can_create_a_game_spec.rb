require 'rails_helper'

describe 'POST /api/v1/games' do
  context 'with an opponent_email' do
    it 'creates a new game against a player' do
      challenger = create(:user)
      defender = create(:user)

      post '/api/v1/games', params: { opponent_email: defender.email }, headers: { 'X-API-Key' => challenger.api_key }

      game_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(game_response[:id]).to eq(1)
    end
  end

  context 'without an opponent_email' do
    it 'creates a new game aginst a computer' do
      challenger = create(:user)

      post '/api/v1/games', params: { opponent_email: nil }, headers: { 'X-API-Key' => challenger.api_key }

      game_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(game_response[:id]).to eq(1)
    end
  end
end
