class Bridge < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }

  def draft?
    !published?
  end
end
