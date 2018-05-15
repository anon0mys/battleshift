require 'rails_helper'

describe PlayerDecorator do
  context 'initializes with a board and user' do
    it 'has user attributes along with player attributes' do
      user = create(:user)
      board = Board.new(4)

      decorator = PlayerDecorator.new(user, board)

      expect(decorator.user).to be_a User
      expect(decorator.board).to be_a Board
      expect(decorator.name).to eq(user.name)
      expect(decorator.api_key).to eq(user.api_key)
      expect(decorator.email).to eq(user.email)
    end
  end
end
