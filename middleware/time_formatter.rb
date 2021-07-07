require_relative '../services/time_converter'

class TimeFormatter
  STATUS = { error: 404, success: 200 }
  TIME_URL = '/time'

  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new(env)
    @request_params = @request.params['format']

    if @request.path == TIME_URL
      handle_time_request
    elsif @request_params.nil?
      final_response(STATUS[:error], headers, ["Unknown time format\n"])
    else
      final_response(STATUS[:error], headers, ["Bad url\n"])
    end
  end

  private

  def handle_time_request
    user_format = @request_params.split(",")
    time_formatter = TimeConverter.new(user_format)

    if time_formatter.acceptably?
      final_response(STATUS[:success], headers, "#{time_formatter.return_time}\n")
    else
      final_response(STATUS[:error], headers, "#{time_formatter.return_time}\n")
    end
  end

  def final_response(status, headers, body)
    response = Rack::Response.new(body, status, headers)
    response.finish
  end

  def headers
    {"Content-type"=>"text-plain"}
  end
end
