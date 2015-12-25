class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

    # before filters
    
    # confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
