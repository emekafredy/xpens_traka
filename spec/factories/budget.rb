FactoryBot.define do
  factory :budget do
    start_date { Time.now }
    end_date { Time.now + 29.days }
    income_estimate { 300000 }
    expense_estimate { 30000 }

    factory :second_budget do
      start_date { Time.now + 30.days }
      end_date { Time.now + 60.days }
      income_estimate { 300000 }
      expense_estimate { 150000 }
    end
  end
end
