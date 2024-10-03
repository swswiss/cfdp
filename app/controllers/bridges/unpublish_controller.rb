module Bridges
  class UnpublishController < ApplicationController
    before_action :authenticate_user!

    def update
      @bridge = Bridge.friendly.find(params[:id])
      @bridge.update(published: false)
      flash[:success] = "Product successfully unpublished."
      redirect_to bridge_path(@bridge)
    end
  end
end