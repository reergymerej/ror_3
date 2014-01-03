class UsersController < ApplicationController
  def show
    #params[:id] == The id in the url.
    # find converts this to an int
    @user = User.find(params[:id])
  end

  def new
  end
end
