class ErrorsController < ApplicationController
	def show
		url = request.original_url
		# If i want to just email the normal rails error page, do this:
		# https://www.honeybadger.io/blog/how-rails-fancy-exception-page-works/
		exception = request.env["action_dispatch.exception"]
		exception_wrapper = ActionDispatch::ExceptionWrapper.new(request.env['action_dispatch.backtrace_cleaner'], exception)
		trace = exception_wrapper.application_trace

		render action: request.path[1..-1]
		if params[:status] != "404"
			ErrorMailer.error_details(url, exception, exception_wrapper, trace).deliver_now
		end
		# email = ErrorMailer.error_details(@exception).deliver_now
		# email.delivery_method.settings.merge!({user_name: ENV['GMAIL_WEBMASTER_ID'], password: ENV['GMAIL_WEBMASTER_PASSWORD']}) #for using non default email
		# email.deliver_now
	end  
end
