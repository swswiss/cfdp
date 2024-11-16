class SuperAdmin::DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index, :approve]
  before_action :authorize_super_admin, only: [:index, :approve]


  def index
    @account_requests = AccountRequest.where(status: 'pending').page(params[:page]).per(5)
    @earnings = Earn.all
  end

 # app/controllers/super_admin/dashboard_controller.rb
def approve
  request = AccountRequest.find(params[:id])
  user = User.create(
    email: request.email,
    username: request.username,
    firstname: request.first_name,
    lastname: request.last_name,
    password: request.password,
    role: params[:role]
  )

  if user.persisted?
    # Destroy the account request after successfully creating the user
    request_id = request.id
    request.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:success] = "Account was successfully created."
        render turbo_stream: [turbo_stream.remove("account_request_#{request_id}"),
        turbo_stream.update( "flash", partial: "layouts/flash")]
      
      end
      format.html { redirect_to super_admin_dashboard_path, notice: "Account was successfully created." }
    end
  else
    redirect_to super_admin_dashboard_path, alert: 'Error approving account.'
  end
end
  

  private

  def authorize_super_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user&.role == 'super admin'
  end
end
