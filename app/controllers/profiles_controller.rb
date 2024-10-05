class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_profile_path(@user), notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation)
  end
end