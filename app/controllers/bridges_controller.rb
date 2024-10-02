class BridgesController < ApplicationController
  before_action :authenticate_user!

	def index
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
			redirect_to bridge_path(@bridge)
		else
			#Error
		end
	end

	private

	def bridge_params
		params.require(:bridge).permit(:name)
	end
end
