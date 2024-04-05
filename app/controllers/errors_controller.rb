class ErrorsController < ApplicationController
  before_action :prepare_error_details, only: [:show]
  rescue_from ActionDispatch::Http::MimeNegotiation::InvalidType, with: :handle_invalid_mime_type

  def show
    log_error
    respond_to do |format|
      format.html { render_error_page }
      format.json { render json: { error: error_message }, status: @status }
      # Add more formats as needed
    end
  end

  private

  def prepare_error_details
    @url = request.original_url
    @exception = request.env["action_dispatch.exception"]
    @exception_wrapper = ActionDispatch::ExceptionWrapper.new(request.env['action_dispatch.backtrace_cleaner'], @exception)
    @trace = @exception_wrapper.application_trace
    @request_params = request.filtered_parameters
    @user_info = current_user.try(:attributes).slice("id", "email") # Ensure you exclude sensitive info
    @status = params[:status] || 500
  end

  def log_error
    # Logging the error
    Rails.logger.error(@exception)
    
    # Sending an email for non-404 errors
    if @status.to_s != "404"
      ErrorMailer.error_details(@url, @exception, @exception_wrapper, @trace, @request_params, @user_info).deliver_now
    end
  end

  def render_error_page
    render action: request.path[1..-1], status: @status
  rescue ActionController::UnknownFormat, ActionView::MissingTemplate
    render "errors/generic_error", status: @status
  end

  def handle_invalid_mime_type(exception)
    render "errors/generic_error", status: :bad_request
  end
end
