class SessionsController < ApplicationController
  def new
    @title = 'Sign in'
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      # since we are only rendering the new session page
      # rather than redirecting, we will have to use flash.now
      # (rather than flash)
      flash.now[:error] = 'Email or password invalid, try again'
      @title = 'Sign in'
      render 'new'
    else
      # remember to sign the user in
      sign_in user
      flash[:success] = 'Welcome back, ' + user.first_name
      #redirect_back_or user_path(user)
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
