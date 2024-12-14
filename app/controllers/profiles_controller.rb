# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:all_users]
  before_action :authorize_super_admin!, only: [:update_role, :destroy]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def all_users
    users_super_admin = User.where(role:'super admin').pluck(:id)
    @users = User.where.not(id: users_super_admin).order(created_at: :asc).page(params[:page]).per(9)
  end

  def update_role
    user = User.find(params[:id])

    if user.admin?
      user.update(role: 'student')
    else
      user.update(role: 'admin')
    end
    respond_to do | format |
      format.turbo_stream do
        flash[:success] = "User successfully roled."
        render turbo_stream: [
          turbo_stream.update("publish-button-#{user.id}", partial: "profiles/publish_button", locals: { user: user.reload }),
          turbo_stream.update("status-#{user.id}", user.admin? ? "Admin" : "Student"),
          turbo_stream.update( "flash", partial: "layouts/flash")
        ]
      end
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to edit_profile_path(user), notice: 'Profile updated successfully'
    else
      redirect_to edit_profile_path(user), notice: user.errors.full_messages.join(",")
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = "User successfully deleted."
    redirect_to all_users_path
  end
  

  private

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless (current_user&.admin? || current_user.super_admin?)
  end

  def authorize_super_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless (current_user.super_admin?)
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :email, :password, :password_confirmation)
  end
end