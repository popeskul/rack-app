require_relative '../services/time_converter'

class TimeFormatter
  STATUS = { error: 404, success: 200 }.freeze
  TIME_URL = '/time'.freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    request_params = request.params['format']

    if request.path != TIME_URL
      body = request_params.nil? ? ["Unknown time format\n"] : ["Bad url\n"]
      final_response(STATUS[:error], headers, body)
    else
      handle_time_request(request_params)
    end
  end

  private

  def handle_time_request(request_params)
    user_format = request_params.split(',')

    time_formatter = TimeConverter.new(user_format)
    time_formatter.call
    if time_formatter.success?
      final_response(STATUS[:success], headers, "#{time_formatter.time_string}\n")
    else
      final_response(STATUS[:error], headers, "#{time_formatter.invalid_string}\n")
    end
  end

  def final_response(status, headers, body)
    response = Rack::Response.new(body, status, headers)
    response.finish
  end

  def headers
    { 'Content-type' => 'text-plain' }
  end
end
