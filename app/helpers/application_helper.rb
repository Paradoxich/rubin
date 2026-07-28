module ApplicationHelper
  def short_time_ago(time)
    seconds = (Time.current - time).to_i
    return "just now" if seconds < 60

    minutes = seconds / 60
    return "#{minutes}m ago" if minutes < 60

    hours = minutes / 60
    return "#{hours}h ago" if hours < 24

    days = hours / 24
    return "#{days}d ago" if days < 30

    months = days / 30
    return "#{months}mo ago" if months < 12

    "#{days / 365}y ago"
  end
end
