class ApplicationController < ActionController::Base 
  # Rescue form for invalid authentificitytoken
  rescue_from ActionController::InvalidAuthenticityToken, :with => :bad_token
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :set_variables, :set_csp_header

  def set_variables
    @bgc_yellow = "#FFF55E" #"#F2E300"
    @bgc_green = "#9CE568" #"#5FC916"
    @bgc_orange = "#FFAB58" #"#ff9933"
    @bgc_pink = "#F473AB" #"#ec1e79"
    @bgc_blue = "#6074B7" #"#223d99"
    @bgc_purple = "#A851DF" #"#8a09db"

    @twenty_years = "none"
    @jr_login = "none"

    @needs_stripe = false
    @tricksu_password = false
    
    @newsletter = WebsitePdf.where(:file_name => "Tricks_Newsletter").first
    @release_form = WebsitePdf.where(:file_name => "Tricks_Release_Form").first
    @family_rules = WebsitePdf.where(:file_name => "Tricks_Family_Rules").first
    @billing_cycle = WebsitePdf.where(:file_name => "Tricks_Billing_Cycle").first
    @folsom_billing_cycle = WebsitePdf.where(:file_name => "Tricks_Folsom_Billing_Cycle").first
    @sacramento_billing_cycle = WebsitePdf.where(:file_name => "Tricks_Sacramento_Billing_Cycle").first
  	@application = WebsitePdf.where(file_name: "Tricks_Instructor_Application").first
    @office_application = WebsitePdf.where(file_name: "Tricks_Office_Application").first
    @summer_recital_info = WebsitePdf.where(file_name: "Summer_Recital_Info").first
    @parties = WebsitePdf.where(file_name: "Parties").first
  end
  
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "You are not authorized to view this page. Please Log In"
  	redirect_to login_path
  end

	private
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	
  def bad_token
    flash[:warning] = "Session expired"
    redirect_to root_path
  end

  def set_csp_header
    response.headers['Content-Security-Policy'] = "frame-ancestors 'self' https://tricksfolsom.com;"
  end
end
