# frozen_string_literal: true

class UserIntegrationsController < ApplicationController
  def index
    @integrations = Integration.all
    @user_integrations = current_user.integrations.pluck(:id) # Get IDs of integrations the current user has
  end

  def update_integrations
    selected_integration_ids = params[:integration_ids] || []
    # Update current user's integrations
    current_user.integrations = Integration.where(id: selected_integration_ids)

    redirect_to user_integrations_path, notice: 'Integrations updated successfully!'
  end
end
