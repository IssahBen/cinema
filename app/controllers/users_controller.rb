# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_user, only: [:show]
  def show
    @redirect_to_page_id = true
    @buckets = current_user.buckets
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'You have Successfully signed up'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = current_user
    if (change_password != false) && !change_password.nil?
      if @user.update(change_password)
        flash[:notice] = 'Account Updated'
        redirect_to @user
      else
        flash.now[:notice] = 'Wrong old password'
      end
    elsif change_password.nil?
      if @user.update(edit_params)
        flash[:notice] = 'Account Updated'
        redirect_to @user
      else
        flash.now[:notice] = "Email or Username can't be edited"
        render 'edit'
      end
    else
      flash.now[:alert] = 'Wrong Old Password'
      render 'edit'
    end
  end

  def change_password
    old_password = password_params[:old_password]
    return nil if old_password == ''

    @user = User.find(params[:id])

    return false unless @user.authenticate(old_password)

    new_params = password_params
    new_params.delete(:old_password)
    edit_params.merge(new_params)
  end

  private

  def edit_params
    params.require(:user).permit(:username, :email)
  end

  def password_params
    params.require(:user).permit(:old_password, :password)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
