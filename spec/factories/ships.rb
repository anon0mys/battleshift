FactoryBot.define do
  factory :ship do
    start_space 'A1'
    end_space 'A2'
    board { build(:board) }
    
    initialize_with { new(board, start_space, end_space) }
  end
end
