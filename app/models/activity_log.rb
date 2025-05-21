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
    PRINT_BRIDGE = 'printed a bridge'.freeze
    PRINT_INSTANCE_BRIDGE = 'printed an instance bridge'.freeze
    CREATED_INTEGRATION_EMAIL = 'created an email integration'.freeze
    CREATED_INTEGRATION_SMS = 'created an sms integration'.freeze
    DELETED_INTEGRATION_EMAIL = 'deleted an email integration'.freeze
    DELETED_INTEGRATION_SMS = 'deleted an sms integration'.freeze
    UPLOADED_IMAGES = 'uploaded %{count} image(s) to instance bridge'.freeze
    DELETED_ONE_IMAGE = 'deleted 1 image from an instance bridge'.freeze
    DELETED_ALL_IMAGES = 'deleted all images from instance bridge'.freeze
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
