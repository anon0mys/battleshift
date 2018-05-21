FactoryBot.define do
  factory :board do
    initialize_with { new(4) }
  end
end
