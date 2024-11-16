class AccountRequest < ApplicationRecord
  validates :email, :username, :first_name, :last_name, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :email_uniqueness_across_models
  validate :username_uniqueness_across_models

  # Optional: Add a method to generate a hashed password for secure storage
  before_save :set_default_status

  private

  # Custom validation to check email uniqueness in both AccountRequest and User models
  def email_uniqueness_across_models
    if User.exists?(email: email) || AccountRequest.exists?(email: email)
      errors.add(:email, 'is already taken')
    end
  end

  # Custom validation to check username uniqueness in both AccountRequest and User models
  def username_uniqueness_across_models
    if User.exists?(username: username) || AccountRequest.exists?(username: username)
      errors.add(:username, 'is already taken')
    end
  end

  def set_default_status
    self.status ||= 'pending'
  end
end
