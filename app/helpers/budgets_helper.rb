module BudgetsHelper
  def actual_income(budget)
    grouped_income = Income.created_between(budget.start_date, budget.end_date, current_user)
    grouped_income.map(&:amount).reduce(:+)
  end

  def actual_expense(budget)
    grouped_expense = Expense.created_between(budget.start_date, budget.end_date, current_user)
    grouped_expense.map(&:amount).reduce(:+)
  end

  def savings_rate(budget)
    difference = actual_income(budget) - actual_expense(budget)
    number_to_percentage((difference / actual_income(budget)) * 100)
  end

  def budget_status(budget)
    case
    when budget.start_date > Date.today
      return 'Open'
    when budget.end_date < Date.today
      return 'Closed'
    when (budget.start_date..budget.start_date).cover?(Date.today)
      return 'In-progress'
    end
  end

  def rate_class(budget)
    savings_rate(budget).to_f >= 0 ? 'budget--show--stats--green' : 'budget--show--stats--red'
  end
end
