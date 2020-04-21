class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.where(user_id: current_user.id).order('created_at DESC')
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def edit; end

  def create
    @expense = current_user.expenses.build(permitted_params)

    upload_image(@expense)

    if @expense.save
      flash[:success] = 'Expense was successfully created.'
      redirect_to expenses_path
    else
      render :new
    end
  end

  def update
    upload_image

    if @expense.update(permitted_params)
      flash[:success] = 'Expense was successfully updated.'
      redirect_to expenses_path
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy

    flash[:success] = 'Expense was successfully deleted.'
    redirect_to expenses_path
  end

  private

  def upload_image(expense = '')
    return unless params[:expense][:image].present?

    @value = Cloudinary::Uploader.upload(params[:expense][:image])

    if expense.present?
      expense.image = @value['secure_url']
    else
      params[:expense][:image] = @value['secure_url']
    end
  end

  def set_expense
    @expense = Expense.where(user_id: current_user.id).find(params[:id])
  end

  def permitted_params
    params.require(:expense).permit(:category, :date, :amount, :image)
  end
end
