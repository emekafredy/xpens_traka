FactoryBot.define do
  factory :income do
    category { :Salary }
    amount { 150000 }
    date { (Time.now) }
  end
end
