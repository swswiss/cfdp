# frozen_string_literal: true

class UserIntegration < ApplicationRecord
  belongs_to :user
  belongs_to :integration
end
