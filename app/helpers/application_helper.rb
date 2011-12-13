module ApplicationHelper

  def localized_time(value, format = :short, blank = nil)
    value.present? ? l(value, :format => format) : blank
  end

  def tick_or_cross(value)
    raw(value ? "&#10003;" : "&#x2718;")
  end
end
