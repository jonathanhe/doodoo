class UsersController < ApplicationController
  def new
    @user = User.new
    @title = 'Sign up'
  end

  def show
    @user = User.find(params[:id])
    @title = 'Welcome ' + @user.first_name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      @title = 'Sign up an account'
      render new_user_path
      #render 'new'
    end
  end

end
