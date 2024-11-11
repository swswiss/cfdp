# frozen_string_literal: true

class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  
  validates :action, presence: true
  validates :timestamp, presence: true

  module ActionTypes
    CREATED_BRIDGE = 'created a bridge'.freeze
    UPDATED_BRIDGE = 'updated a bridge'.freeze
    DESTROY_BRIDGE = 'destroyed a bridge'.freeze
    CREATED_INSTANCE_BRIDGE = 'created an instance bridge'.freeze
    UPDATED_INSTANCE_BRIDGE = 'updated an instance bridge'.freeze
    DESTROY_INSTANCE_BRIDGE = 'destroyed an instance bridge'.freeze
    # Add more actions as needed...
  end

  # Optionally, add a method for logging activity
  def self.log_activity(user, action, trackable, name = "")
    create(
      user: user,
      action: action,
      trackable: trackable,
      name: name,
      timestamp: Time.current
    )
  end

  def time_since_activity
    "#{time_ago_in_words(timestamp)} ago"
  end
end
