class InstanceBridge < ApplicationRecord
  belongs_to :bridge

  validates :name, presence: true
  # Add any other validations here
end