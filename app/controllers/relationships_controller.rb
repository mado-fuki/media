class RelationshipsController < ApplicationController
  before_action :logged_in_user_ajax

  def create
    @user = User.find(params[:followed_id])
    @post = Post.find(params[:post_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    @post = Post.find(params[:post_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
