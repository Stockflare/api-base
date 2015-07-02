FactoryGirl.define do
  factory :unit do
    quantity { rand(1...1000) }
  end
end
