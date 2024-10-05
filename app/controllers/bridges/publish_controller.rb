module Bridges
  class PublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @bridge = Bridge.friendly.find(params[:id])
      @bridge.update(published: true)
      respond_to do | format |
        format.turbo_stream do
          flash[:success] = "Product successfully published."
          render turbo_stream: [
            turbo_stream.update("publish-button-#{@bridge.id}", partial: "bridges/publish_button", locals: { bridge: @bridge.reload }),
            turbo_stream.update("status-#{@bridge.id}", @bridge.published? ? "Published" : "Unpublished"),
            turbo_stream.update( "flash", partial: "layouts/flash")
          ]
        end
      end
    end
  end
end
