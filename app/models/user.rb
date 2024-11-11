# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  validates :password, presence: true, confirmation: true, length: { within: 6..128 }, if: :password_required?

  has_many :bridges, dependent: :destroy
  has_many :instance_bridges, through: :bridges, dependent: :destroy

  has_many :activity_logs, dependent: :destroy

  has_many :user_integrations
  has_many :integrations, through: :user_integrations

  def admin?
    role == 'admin'
  end

  def super_admin?
    role == 'super admin'
  end

  def student?
    role == 'student'
  end

  def password_required?
    # Password is required if it's a new record or if the user is changing their password (password or password_confirmation is filled in)
    !persisted? || (!password.blank? || !password_confirmation.blank?)
  end

  def user_has_email_integration?
    self.integrations.exists?(integration_type: 'Email')
  end
end
