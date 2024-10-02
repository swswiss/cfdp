class DashboardController < ApplicationController
	before_action :authenticate_user!
	
	def index
		flash.now[:notice] ={
			title: "Successfully Sign In", 
			body: "Welcome to our application"
		}
	end
end
