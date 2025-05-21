# frozen_string_literal: true

class Bridge < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :instance_bridges, dependent: :destroy

  has_one :flaw, dependent: :destroy
  accepts_nested_attributes_for :flaw

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validate :bridge_limit, on: :create

  def draft?
    !published?
  end

  private

  def bridge_limit
    if user.bridges.count >= 1 && user.role == 'student'
      errors.add(:base, "You can only create only 1 bridge.")
    end
  end
end
