class ErrorsController < ApplicationController
  def show
    url = request.original_url
    exception = request.env["action_dispatch.exception"]
    exception_wrapper = ActionDispatch::ExceptionWrapper.new(request.env['action_dispatch.backtrace_cleaner'], exception)
    trace = exception_wrapper.application_trace
    request_params = request.filtered_parameters # Ensure this only includes what you're comfortable logging
    user_info = current_user.try(:attributes) # Adjust based on your user model, ensure sensitive info is excluded

    # Optionally, only email for certain types of errors
    if params[:status] != "404"
      ErrorMailer.error_details(url, exception, exception_wrapper, trace, request_params, user_info).deliver_now
    end

    # Attempt to render the error page if one exists for the status code
    render action: request.path[1..-1], status: params[:status] || 500
  rescue ActionController::UnknownFormat, ActionView::MissingTemplate => e
    # If there's no template for the error, you might want to render a generic error page
    render "errors/generic_error", status: params[:status] || 500 # Ensure you have a generic_error.html.erb
  end
end
