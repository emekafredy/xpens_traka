class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.where(user_id: current_user.id).order("created_at DESC")
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = current_user.expenses.build(permitted_params)

    if @expense.save
      flash[:success] = 'Expense was successfully created.'
      redirect_to expenses_path
    else
      flash.now[:error] = @expense.errors.full_messages
      render :new
    end
  end

  def update
    respond_to do |format|
      if @expense.update(permitted_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = Expense.where(user_id: current_user.id).find(params[:id])
    end

    def permitted_params
      params.require(:expense).permit(:user_id, :category, :date, :amount)
    end
end
