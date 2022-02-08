class SignupMailer < ApplicationMailer
  def notification(user)
    @user = user        
    mail to: "trickswebmaster@gmail.com", subject: "User created for: " + @user.email
  end
end
