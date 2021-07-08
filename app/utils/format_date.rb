class FormatDate
  def self.yyyy_mm_dd_wd(date)
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    date.strftime("%Y/%m/%d(#{wd[date.wday]})")      
  end
end

