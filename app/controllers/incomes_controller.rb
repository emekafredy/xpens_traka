class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def index
    @incomes = Income.where(user_id: current_user.id).order("created_at DESC")
  end

  def show
  end

  def new
    @income = Income.new
  end

  def edit
  end

  def local_image_path(name)
    Rails.root.join('app/assets/images/icons', name).to_s
  end

  def create
    @income = current_user.incomes.build(permitted_params)

    if params[:income][:image].present?
      @value = Cloudinary::Uploader.upload(params[:income][:image])
      @income.image = @value['secure_url']
    end

    if @income.save
      flash[:success] = 'Income was successfully created.'
      redirect_to incomes_path
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @income.update(permitted_params)
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_income
      @income = Income.where(user_id: current_user.id).find(params[:id])
    end

    def permitted_params
      params.require(:income).permit(:category, :date, :amount, :image)
    end
end
