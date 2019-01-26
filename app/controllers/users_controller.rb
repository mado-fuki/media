class UsersController < ApplicationController
  def show
    @name = "test_user" + "2"
    render html: @name
  end

  def new
  end

  def edit
  end
end
