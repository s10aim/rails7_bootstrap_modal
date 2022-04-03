class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  PER_PAGE = 10

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 一覧表示は1ページ目に戻す
      @users = User.order(created_at: :desc).page(nil).per(PER_PAGE)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    render :edit, status: :unprocessable_entity unless @user.update(user_params)
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :gender, :age, :tel, :birth_date)
  end
end
