class ImagesController < ApplicationController

  def edit
    @post = Post.find(params[:post_id])
  end
end