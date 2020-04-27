class HomepageController < ApplicationController
  def index
    @incomes = Income.where(user_id: current_user.id)
    @expenses = Expense.where(user_id: current_user.id)
  end
end
