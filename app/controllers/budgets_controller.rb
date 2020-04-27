class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  BUDGETS_PER_PAGE = 10

  def index
    @budgets = Budget.where(user_id: current_user.id).order('start_date DESC').paginate(page: params[:page], per_page: BUDGETS_PER_PAGE)
  end

  def show; end

  def new
    @budget = Budget.new
  end

  def edit; end

  def create
    @budget = current_user.budgets.build(permitted_params)

    if @budget.save
      flash[:success] = 'Budget was successfully created.'
      redirect_to budgets_path
    else
      render :new
    end
  end

  def update
    if @budget.update(permitted_params)
      flash[:success] = 'Budget was successfully updated.'
      redirect_to budgets_path
    else
      render :edit
    end
  end

  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: 'Budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_budget
    @budget = Budget.where(user_id: current_user.id).find(params[:id])
  end

  def permitted_params
    params.require(:budget).permit(:start_date, :end_date, :income_estimate, :expense_estimate)
  end
end
