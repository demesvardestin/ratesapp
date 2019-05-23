class RequestMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: 'no-reply@myrates.co'
 
    def send_request(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        
        mail(to: @promoter.email, subject: "New promo request: #{@request.token}")
    end
    
    def send_welcome_email(promoter)
        @promoter = promoter
        
        mail(to: @promoter.email, subject: "Welcome to MyRates!")
    end
end
