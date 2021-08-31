class EmploymentApplicationMailer < ApplicationMailer
  def gym_notification(review)
    @review = review
    subject = "Employment Application for: " + @review.employment_application.firstname + " " + @review.employment_application.lastname
    
    mail to: "trickswebmaster@gmail.com", cc: get_location_email(review.location), subject: subject #TODO: change to bcc: after i have verified it works
  end
  
  def application_confirmation(application)
    @application = application
    subject = "Application for Tricks Gymnastics received"
    
    mail to: application.email, cc: "trickswebmaster@gmail.com", subject: subject
  end
end
