class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

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
      sign_in @user
      flash[:success] = 'Welcome, ' + @user.first_name
      redirect_to @user
    else
      @title = 'Sign up an account'
      render new_user_path
      #render 'new'
    end
  end

  def edit
    # Since we are checking @user within the correct_user method,
    # we don't need to retrieve the user here again
    #@user = User.find(params[:id])
    @title = "Edit your account information"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # we have successfully updated user profile,
      # redirect to the user show page
      flash[:success] = 'Successfully updated your account info!'
      @title = 'Welcome ' + params[:user][:first_name]
      redirect_to @user
    else
      # Something is wrong, re-render the edit page
      flash.now[:error] = 'Failed to update your account info. Please check and re-submit'
      @title = 'Edit your account information'
      render 'edit'
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      deny_and_redirect_to_root unless current_user?(@user)
    end
end
