FactoryBot.define do
  factory :game do
    player_1_board Board.new(4)
    player_2_board Board.new(4)
    winner nil
    player_1_turns 0
    player_2_turns 0
    current_turn 'player_1'
    association :player_1, factory: :user
    association :player_2, factory: :artie
  end
end
