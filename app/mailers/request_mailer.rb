class RequestMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: 'MyRates@myrates.co'
 
    def send_request(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: "New promo request: #{@request.token}")
        end
    end
    
    def send_welcome_email(promoter)
        @promoter = promoter
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: "Welcome to MyRates!")
        end
    end
end
