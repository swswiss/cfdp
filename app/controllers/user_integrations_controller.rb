# frozen_string_literal: true

class UserIntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
    @user_integrations = current_user.integrations.pluck(:id) # Get IDs of integrations the current user has
  end

  def update_integrations
    selected_integration_ids = params[:integration_ids] || []
    previous_ids = current_user.integrations.pluck(:id).map(&:to_s)
    new_ids = selected_integration_ids.map(&:to_s)

    added_ids   = new_ids - previous_ids
    removed_ids = previous_ids - new_ids
    # Create activity logs for added integrations
    Integration.where(id: added_ids).each do |integration|
      if integration.id == 1
        ActivityLog.log_activity(
          current_user,
          ActivityLog::ActionTypes::CREATED_INTEGRATION_EMAIL,
          Integration.last,
          "Email Integration"
        )
      elsif integration.id == 2
        ActivityLog.log_activity(
          current_user,
          ActivityLog::ActionTypes::CREATED_INTEGRATION_SMS,
          Integration.last,
          "SMS Integration"
        )
      end
    end

    # Create activity logs for removed integrations
    Integration.where(id: removed_ids).each do |integration|
      if integration.id == 1
        ActivityLog.log_activity(
          current_user,
          ActivityLog::ActionTypes::DELETED_INTEGRATION_EMAIL,
          Integration.last,
          "Email Integration"
        )
      elsif integration.id == 2
        ActivityLog.log_activity(
          current_user,
          ActivityLog::ActionTypes::DELETED_INTEGRATION_SMS,
          Integration.last,
          "SMS Integration"
        )
      end
    end
    # Update current user's integrations
    current_user.integrations = Integration.where(id: selected_integration_ids)

    redirect_to user_integrations_path, notice: 'Integrations updated successfully!'
  end
end
