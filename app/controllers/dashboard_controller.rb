# frozen_string_literal: true

class DashboardController < ApplicationController
	before_action :authenticate_user!
	
	def index
		if session[:signed_in]
      flash.now[:notice] = {
        title: "Successfully Sign In", 
        body: "Welcome to our application"
      }
      # Clear the session variable
      session.delete(:signed_in)
    end
	end
end
