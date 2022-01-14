FactoryBot.define do
  factory :bachelorette do
    sequence(:name) { |n| "bach_#{n}" }
    sequence(:season_number) { |n| n }
    sequence(:desc) { |n| "desc_#{n}" }
  end
end
