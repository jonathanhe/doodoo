class UsersController < ApplicationController
  def new
    @title = 'Sign up'
  end

  def show
    @user = User.find(params[:id])
    @title = 'Welcome ' + @user.first_name
  end

end
