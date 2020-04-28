class ReportsController < ApplicationController
  def new_incomes_report; end

  def new_expenses_report; end

  def download_incomes
    @incomes = Income.created_between(params[:start_date].to_date, params[:end_date].to_date, current_user)
    render(xlsx: 'download_incomes', formats: [:xlsx], filename: 'incomes_report')
  end

  def download_expenses
    @expenses = Expense.created_between(params[:start_date].to_date, params[:end_date].to_date, current_user)
    render(xlsx: 'download_expenses', formats: [:xlsx], filename: 'expenses_report')
  end
end
