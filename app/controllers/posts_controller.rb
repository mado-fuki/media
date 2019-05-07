class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy, :following, :followers]
  before_action :correct_user, only: :destroy

  def index
    # ページがリロードされても検索ワードをformに保持する
    unless params[:q].blank?
      words_array = []
      for param in params[:q][:groupings] do
        words_array.push(param[:title_or_content_or_tags_name_cont])
      end
      @words = words_array.join(' ')
    end
  end

  def search_tags
    @search_posts = Post.tagged_with(params[:tag]).page(params[:page]).per(21)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    if logged_in?
      @post = current_user.posts.build
      @post.images.build
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:images]['image'].length > 6
      @post.errors.add(:images, "は6枚までです。")
      render 'new' and return
    elsif @post.save
      params[:images]['image'].each do |i|
        @image = @post.images.create!(image: i)
      end
      flash[:success] = '記事を投稿しました。'
      redirect_to "/users/#{current_user.id}"
    else
      render 'new' and return
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
    if @post.update_attributes(title: post_params[:title], content: post_params[:content], tag_list: post_params[:tag_list])
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
    redirect_to current_user
  end
  

  private

    def post_params
      params.require(:post).permit(:title, :content, :tag_list, images_attributes: [:image])
    end

    def images_params
      params.require(:images).permit(image: [])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
