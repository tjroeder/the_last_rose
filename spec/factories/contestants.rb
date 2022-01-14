FactoryBot.define do
  factory :contestant do
    sequence(:name) { |n| "cont_#{n}" }
    sequence(:age) { |n| n }
    sequence(:hometown) { |n| "hometown_#{n}" }
    
    bachelorette
  end
end
