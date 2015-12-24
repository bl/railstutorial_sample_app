class SessionsController < ApplicationController
  def new
  end

  def create
    # retrieve user matching email
    user = User.find_by(email: params[:session][:email].downcase)
    # verify user exists and password submitted matches
    if user && user.authenticate(params[:session][:password])
      # log the user in and redirect to the user's show page
      log_in user
      redirect_to user
    else
      # create an error message
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
