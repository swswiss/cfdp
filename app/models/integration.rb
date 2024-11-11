# frozen_string_literal: true

class Integration < ApplicationRecord
  has_many :user_integrations
  has_many :users, through: :user_integrations
end
