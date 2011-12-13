module ApplicationHelper
  def tick_or_cross(value)
    raw(value ? "&#10003;" : "&#x2718;")
  end
end
