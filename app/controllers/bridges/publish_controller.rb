module Bridges
  class PublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @bridge = Bridge.friendly.find(params[:id])
      @bridge.update(published: true)
      flash[:success] = "Product successfully published."
      redirect_to your_bridges_path
    end
  end
end