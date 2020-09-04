FactoryBot.define do
  factory :income do
    category { :Salary }
    amount { 50000 }
    date { (Time.now) }
  end
end
