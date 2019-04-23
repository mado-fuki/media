class MainController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
    end
  end
end
