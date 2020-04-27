class HomepageController < ApplicationController
  def index
    if current_user
      @incomes = Income.where(user_id: current_user.id)
      @expenses = Expense.where(user_id: current_user.id)
    end
  end
end
