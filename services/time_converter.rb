class TimeConverter
  ACCEPTABLE_FORMAT = {
    'year' => '%Y', 'month' => '%m', 'day' => '%d',
    'hour' => '%H', 'minute' => '%m', 'second' => '%S'
  }.freeze

  attr_reader :time_string, :invalid_string

  def initialize(array)
    @format = array
  end

  def call
    if success?
      full_date = @format.reduce([]) { |acc, param| acc << ACCEPTABLE_FORMAT[param] }.join('-')
      @time_string = Time.now.strftime(full_date)
    else
      @invalid_string = invalid_params
    end
  end

  def success?
    invalid_params.empty?
  end

  private

  def invalid_params
    @format - ACCEPTABLE_FORMAT.keys
  end
end
