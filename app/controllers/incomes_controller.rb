class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def index
    @incomes = Income.where(user_id: current_user.id).order('date DESC')
  end

  def show; end

  def new
    @income = Income.new
  end

  def edit; end

  def create
    @income = current_user.incomes.build(permitted_params)

    upload_image(@income)

    if @income.save
      flash[:success] = 'Income was successfully created.'
      redirect_to incomes_path
    else
      render :new
    end
  end

  def update
    upload_image

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

  def upload_image(income = '')
    return unless params[:income][:image].present?

    @value = Cloudinary::Uploader.upload(params[:income][:image])
    if income.present?
      income.image = @value['secure_url']
    else
      params[:income][:image] = @value['secure_url']
    end
  end

  def set_income
    @income = Income.where(user_id: current_user.id).find(params[:id])
  end

  def permitted_params
    params.require(:income).permit(:category, :date, :amount, :image)
  end
end
