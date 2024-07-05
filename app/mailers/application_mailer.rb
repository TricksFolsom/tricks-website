class ApplicationMailer < ActionMailer::Base
  default from: "Tricks Gymnastics, Dance & Swim <no_reply@tricksgym.com>"
  
  def get_location_email(location)
    if Rails.env.production?
      if (location == "Folsom" || location == "folsom")
        return "tricksfol@gmail.com"
      elsif (location == "Sacramento" || location == "sacramento")
        return "trickssac@gmail.com"
      else
        return "football80@gmail.com"
      end
    else
      return "football80@gmail.com" #trickswebmaster@gmail.com ?
    end
  end
end
