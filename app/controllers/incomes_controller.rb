class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  INCOMES_PER_PAGE = 10

  def index
    @incomes = Income.where(user_id: current_user.id).order('date DESC').paginate(page: params[:page], per_page: INCOMES_PER_PAGE)
  end

  def show; end

  def new
    @income = Income.new
  end

  def edit; end

  def create
    @income = current_user.incomes.build(permitted_params)

    upload_file(@income)

    if @income.save
      flash[:success] = 'Income was successfully created.'
      redirect_to incomes_path
    else
      render :new
    end
  end

  def update
    upload_file

    if @income.update(permitted_params)
      flash[:success] = 'Income was successfully updated.'
      redirect_to incomes_path
    else
      render :edit
    end
  end

  def destroy
    @income.destroy

    flash[:success] = 'Income was successfully deleted.'
    redirect_to incomes_path
  end

  private

  def upload_file(income = '')
    return unless params[:income][:file].present?

    @value = Cloudinary::Uploader.upload(params[:income][:file])
    if income.present?
      income.file = @value['secure_url']
    else
      params[:income][:file] = @value['secure_url']
    end
  end

  def set_income
    @income = Income.where(user_id: current_user.id).find(params[:id])
  end

  def permitted_params
    params.require(:income).permit(:category, :date, :amount, :file)
  end
end
