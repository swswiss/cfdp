# frozen_string_literal: true

class InstanceBridge < ApplicationRecord
  belongs_to :bridge
  has_many_attached :avatars
  has_one :flaw_instance, dependent: :destroy
  accepts_nested_attributes_for :flaw_instance

  before_create :set_instance_bridge_name
  before_destroy :purge_avatars 

  validate :instance_bridge_limit, on: [:create, :clone]

  private

  def purge_avatars
    avatars.each(&:purge)
  end

  def set_instance_bridge_name
    existing_names = bridge.instance_bridges.pluck(:name)

    max_instance_number = existing_names.map do |name|
      match = name.match(/(\d+)$/)
      match ? match[1].to_i : 0
    end.max || 0

    self.name = "#{bridge.name} #{max_instance_number + 1}"
  end

  def instance_bridge_limit
    if self.bridge.user.instance_bridges.size >= 1 && self.bridge.user.role == 'student'
      errors.add(:base, "You can only create up to 1 instance bridge.")
    end
  end

end