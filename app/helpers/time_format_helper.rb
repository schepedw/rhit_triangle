module TimeFormatHelper
  def clock_time_format
    '%l:%M%P'
  end

  def this_week_format
    '%a %l:%M%P'
  end

  def this_year_format
    '%b %-d %l:%M%P'
  end

  def legible_timestamp_format
    '%b %-d, %Y @ %l:%M%P'
  end
end
