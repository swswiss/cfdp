class AccountRequestsController < ApplicationController

  def new
    redirect_to root_path if user_signed_in?
    @account_request = AccountRequest.new
  end

  def create
    @account_request = AccountRequest.new(account_request_params)
    if @account_request.save
      redirect_to root_path, notice: 'Account request submitted successfully. You will be notified once approved.'
    else
      redirect_to new_account_request_path, notice: @account_request.errors.full_messages.to_sentence
    end
  end

  def approve
    request = AccountRequest.find(params[:id])
    user = User.create(
      email: request.email,
      username: request.username,
      first_name: request.first_name,
      last_name: request.last_name,
      password: request.password
    )
    if user.persisted?
      request.update(status: 'approved')
      redirect_to account_requests_path, notice: 'Account approved successfully.'
    else
      redirect_to account_requests_path, alert: 'Error approving account.'
    end
  end

  private
  
  def account_request_params
    params.require(:account_request).permit(:email, :username, :first_name, :last_name, :password)
  end
end