FactoryBot.define do
  factory :outing do
    sequence(:name) { |n| "out_#{n}" }
    sequence(:location) { |n| "location_#{n}" }
    sequence(:date) { |n| (Date.new(2000,12,31) + n.days).strftime('%d/%m/%Y') }
  end
end
