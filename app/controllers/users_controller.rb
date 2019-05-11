class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy following followers)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(21)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_avatar
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールを更新しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def update_avatar
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィール画像を更新しました。'
      redirect_to "/users/#{current_user.id}/edit_avatar"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーの削除に成功しました。'
    redirect_to users_url
  end

  def following
    @title = "フォロー一覧"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.js
    end
    render 'show_follow'
  end

  def followers
    @title = "フォロワー一覧"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.js
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end