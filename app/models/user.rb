class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  validates :password, presence: true, confirmation: true, length: { within: 6..128 }, if: :password_required?

  has_many :bridges
  has_many :activity_logs, dependent: :destroy

  def admin?
    role == 'admin'
  end

  def password_required?
    # Password is required if it's a new record or if the user is changing their password (password or password_confirmation is filled in)
    !persisted? || (!password.blank? || !password_confirmation.blank?)
  end
end
