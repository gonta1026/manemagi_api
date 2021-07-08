class FormatDate
  def self.format_yyyy_mm_dd_wd(date)
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    time = Time.now
    date.strftime("%Y/%m/%d(#{wd[time.wday]})")      
  end
end

