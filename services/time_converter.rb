class TimeConverter
  ACCEPTABLE_FORMAT = %w(year month day hour minute second)

  def initialize(array)
    @format = array
  end

  def acceptably?
    (@format - ACCEPTABLE_FORMAT).empty?
  end

  def unknown_time_format
    @format - ACCEPTABLE_FORMAT
  end

  def convert_user_format
    @format.map { |t| Time.now.send(t) }.join("-")
  end

  def return_time
    if acceptably?
      convert_user_format
    else
      unknown_time_format
    end
  end
end
