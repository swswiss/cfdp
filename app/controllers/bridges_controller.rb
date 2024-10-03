class BridgesController < ApplicationController
  before_action :authenticate_user!

	def index
		@bridges = Bridge.all
	end

	def new
		@bridge = current_user.bridges.build
	end

	def show
		@bridge = Bridge.friendly.find(params[:id])
	end

	def create
		@bridge = Bridge.new(bridge_params.merge(user: current_user))

		if @bridge.save
			redirect_to bridge_path(@bridge), notice: 'Bridge was successfully created.'
		else
		end
	end

	def destroy
    @bridge = Bridge.friendly.find(params[:id])
    @bridge.destroy

    redirect_to bridges_path, notice: 'Bridge was successfully deleted.'
  end

	private

	def bridge_params
		params.require(:bridge).permit(:name)
	end
end
