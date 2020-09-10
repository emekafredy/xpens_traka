FactoryBot.define do
  factory :expense do
    category { :Utility }
    amount { 3000 }
    date { (Time.now) }
  end
end
