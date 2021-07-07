class TimeConverter
  ACCEPTABLE_FORMAT = {
    'year' => '%Y', 'month' => '%m', 'day' => '%d',
    'hour' => '%H', 'minute' => '%m', 'second' => '%S'
  }.freeze

  def initialize(array)
    @format = array
  end

  def call
    if valid_params?
      full_date = @format.reduce([]) { |acc, param| acc << ACCEPTABLE_FORMAT[param] }.join('-')
      Time.now.strftime(full_date)
    else
      invalid_params
    end
  end

  def invalid_params
    @format - ACCEPTABLE_FORMAT.keys
  end

  def valid_params?
    invalid_params.empty?
  end
end
