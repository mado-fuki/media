class PasswordResetsController < ApplicationController
  before_action :get_user,   only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'パスワード再設定メールを送信しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'メールアドレスが間違っています。'
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードがリセットされました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    #before

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワードリセットの期限が切れました。再送信してください。"
        redirect_to new_password_reset_url
      end
    end
end
