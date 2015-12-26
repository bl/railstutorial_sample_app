class SessionsController < ApplicationController
  def new
  end

  def create
    # retrieve user matching email
    @user = User.find_by(email: params[:session][:email].downcase)
    # verify user exists and password submitted matches
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        # log the user in and redirect to the user's show page
        log_in @user
        # store user remember token
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else # user has not been activated, return to root page
        messages = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # create an error message
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
