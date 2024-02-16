class CommentMailer < ApplicationMailer
    def comment_notification(comment)
        @comment = comment
        @subject = "Honey pot worked"
        
        
        mail to: "football80@gmail.com", subject: @subject
    end
end
