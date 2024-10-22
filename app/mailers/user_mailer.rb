class UserMailer < ApplicationMailer
  default from: 'cfdp@example.com'

  def create_bridge bridge
    @user = params[:user]
    @bridge = bridge
    mail(to: @user.email, subject: 'You have just created a bridge!')
  end
end