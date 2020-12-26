FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "ABC #{n}" }
    sequence(:description) { |n| "The ABC Book #{n}" }
  end
end
