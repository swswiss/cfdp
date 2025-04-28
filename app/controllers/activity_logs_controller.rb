# frozen_string_literal: true

class ActivityLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin!, only: [:destroy]

	def index
		if params[:name].blank? && params[:name_action].blank?
			@activity_logs = ActivityLog.includes(:user).order(created_at: :desc).page(params[:page]).per(7)
			logs = @activity_logs.size
			if logs > 200
				diff = logs - 200
				@activity_logs.last(diff).destroy_all
			end
		end

		if params[:name].present? && params[:name_action].blank?
			user_ids = User.where('username LIKE ?', "%#{params[:name]}%").pluck(:id)
			@activity_logs = ActivityLog.includes(:user).where(user_id: user_ids).page(params[:page]).per(7)
		end

		if params[:name_action].present? && params[:name].blank?
			@activity_logs = ActivityLog.includes(:user).where('action LIKE ?', "%#{params[:name_action]}%").page(params[:page]).per(7)
		end

		if params[:name_action].present? && params[:name].present?
			user_ids = User.where('username LIKE ?', "%#{params[:name]}%").pluck(:id)
			@activity_logs = ActivityLog.includes(:user).where(user_id: user_ids).where('action LIKE ?', "%#{params[:name_action]}%").page(params[:page]).per(7)
		end
	end

  def destroy
    activity_log = ActivityLog.find(params[:id])
    activity_log.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Activity Log successfully deleted."
        render turbo_stream: [turbo_stream.remove("activity-log-row-#{activity_log.id}"),
				turbo_stream.update( "flash", partial: "layouts/flash")]
			
      end
      format.html { redirect_to bridges_path, notice: "Activity Log was successfully deleted." }
    end
  end

  private

  def authorize_super_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless (current_user&.super_admin?)
  end
end