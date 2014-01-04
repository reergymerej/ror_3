class UsersController < ApplicationController
  def show
    #params[:id] == The id in the url.
    # find converts this to an int
    @user = User.find(params[:id])
  end

  def new
    # Create a variable for use in the new.html.erb view.
    @user = User.new
  end

  def create

    # create user with custom method to return clean params
    @user = User.new(user_params)

    if @user.save
      # add to flash so it can be displayed on the view
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    # custom method to return clean user params
    def user_params
      # params is automatically available to to the controller

      params.require(:user)
        .permit(:name, :email, :password, :password_confirmation)
    end
end
