class InstanceBridge < ApplicationRecord
  belongs_to :bridge
  has_one :flaw_instance, dependent: :destroy
  accepts_nested_attributes_for :flaw_instance

  before_create :set_instance_bridge_name

  private

  def set_instance_bridge_name
    existing_names = bridge.instance_bridges.pluck(:name)

    max_instance_number = existing_names.map do |name|
      match = name.match(/(\d+)$/)
      match ? match[1].to_i : 0
    end.max || 0

    self.name = "#{bridge.name} #{max_instance_number + 1}"
  end

end