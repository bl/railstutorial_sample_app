class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # not final implementation
    if @user.save
      # log-in user
      log_in @user
      # add flash for next user page load
      flash[:success] = "Welcome to the Sample App!"
      # redirect newly added user to user_url(@user)
      redirect_to @user
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end
end
