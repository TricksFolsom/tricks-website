def error_details(url, error, exception_wrapper, trace, request_params = nil, user = nil)
  @url = url
  @error = error
  @exception_wrapper = exception_wrapper
  @trace = trace
  @request_params = request_params
  @user = user # Assuming you have user information
  @message = error.nil? ? "No Error" : error.message
  @timestamp = Time.current.to_s(:db) # Format as you prefer
  mail to: "trickswebmaster@gmail.com", subject: "Website Error: #{@message}"
end