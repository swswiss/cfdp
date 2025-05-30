# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:, data:)
    @type = type
    @data = prepare_data(data)
    @icon_class = icon_class
    @icon_color_class = icon_color_class
  end

  private

  def prepare_data(data)
    case data
    when Hash
      data 
    else
      { title: data }
    end 
  end

  def icon_class
    case @type
    when "success"
      "fas fa-check"
    when "error"
      "fas fa-exclamation"
    when "alert"
      "fas fa-exclamation"
    else
      "fa fa-info"
    end 
  end

  def icon_color_class
    case @type 
    when "success"
      "text-green-400"
    when "error"
      "text-red-400"
    when "alert"
      "text-red-400"
    else
      "text-gray-400"
    end
  end
end
