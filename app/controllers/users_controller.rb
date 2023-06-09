class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week = @books.created_this_week
    @last_week = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def following
    user = User.find(params[:id])
    @user = user.following_user
  end
  
  def followers
    user = User.find(params[:id])
    @user = user.follower_user
  end
  
  def date_search
    @user = User.find(params[:user_id])
    if params[:created_at] == ""
      @books = "日付を選択してください"
    else
      create_at = params[:created_at]
      @books = @user.books.where(['created_at LIKE ? ', "#{create_at}%"])
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end