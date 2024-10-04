class Bridge < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :instance_bridges, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }

  def draft?
    !published?
  end
end
