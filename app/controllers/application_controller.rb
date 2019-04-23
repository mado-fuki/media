class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_search

  def set_search
    words = params[:q].delete(:title) if params[:q].present?
    if words.present?
      params[:q][:groupings] = []
      words.split(/[ 　]/).each_with_index do |word, i|
        params[:q][:groupings][i] = { title_or_content_or_tags_name_cont: word }
      end
    end
    @q = Post.ransack(params[:q])
    @search_posts = @q.result(distinct: true).page(params[:page]).per(20)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインしてください。'
        redirect_to login_url
      end
    end
end
