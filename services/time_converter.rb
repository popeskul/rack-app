class TimeConverter
  ACCEPTABLE_FORMAT = {
    'year' => '%Y', 'month' => '%m', 'day' => '%d',
    'hour' => '%H', 'minute' => '%m', 'second' => '%S'
  }.freeze

  attr_reader :wrong_formats

  def initialize(array)
    @format = array
    @valid_formats = []
    @wrong_formats = []
  end

  def call
    @format.each do |f|
      if ACCEPTABLE_FORMAT.key?(f)
        @valid_formats << ACCEPTABLE_FORMAT[f]
      else
        @wrong_formats << f
      end
    end
  end

  def success?
    invalid_params.empty?
  end

  def valid_formats
    Time.now.strftime(@valid_formats.join('-'))
  end

  private

  def invalid_params
    @format - ACCEPTABLE_FORMAT.keys
  end
end
