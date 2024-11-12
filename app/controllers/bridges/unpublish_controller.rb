# frozen_string_literal: true

module Bridges
  class UnpublishController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_bridge, only: [:update]

    def update
      bridge = Bridge.friendly.find(params[:id])
      bridge.update(published: false)
      respond_to do | format |
        format.turbo_stream do
          flash[:success] = "Product successfully unpublished."
          render turbo_stream: [turbo_stream.update("publish-button-#{bridge.id}", partial: "bridges/publish_button",locals: { bridge: bridge.reload }),
          turbo_stream.update("status-#{bridge.id}", bridge.published? ? "Published" : "Unpublished"),
          turbo_stream.update( "flash", partial: "layouts/flash")
        ]
        end
      end
    end

    private

    def authorize_bridge
      bridge = Bridge.friendly.find(params[:id])
      if bridge.user != current_user
        if current_user.admin? || current_user.super_admin?
          true
        else
          redirect_to bridges_path, notice: 'You have no access here!'
        end
      else
        true
      end
    end
  end
end
