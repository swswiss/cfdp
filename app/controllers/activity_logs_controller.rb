# frozen_string_literal: true

class ActivityLogsController < ApplicationController
  before_action :authenticate_user!

	def index
		if params[:name].blank? && params[:name_action].blank?
			@activity_logs = ActivityLog.includes(:user).order(created_at: :desc).page(params[:page]).per(7)
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
end