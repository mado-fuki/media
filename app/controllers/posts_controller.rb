class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :destroy

  def show
    @post = Post.find(params[:id])
  end

  def new
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.page(params[:page]).per(20)
      @post.images.build
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      params[:images]['image'].each do |i|
        @image = @post.images.create!(image: i)
      end
      flash[:success] = '記事を投稿しました。'
      redirect_to root_url
    else
      @feed_items = []
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def edit_images
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(title: post_params[:title], content: post_params[:content])
      flash[:success] = '記事を更新しました。'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def update_images
    @post = Post.find(params[:id])
    Post.transaction do
      @post.images.each do |i|
        i.destroy!
      end
      @params = images_params
      @params['image'].each do |i|
        @image = @post.images.create!(image: i)
      end
    end
    flash[:success] = '画像を更新しました。'
    redirect_to @post
  end

  def destroy
    @post.destroy
    flash[:success] = '記事を削除しました。'
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, images_attributes: [:image])
    end

    def images_params
      params.require(:images).permit(image: [])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
