class RequestMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: "MyRates <no-reply@myrates.co>"
    default sender: 'MyRates'
    default reply_to: 'teammyrates@gmail.com'
    default unsubscribe: 'https://myrates.herokuapp.com/account/settings'
 
    def send_request(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        attachments['image.png'] = @request.image.url if @request.image?
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: "You have a new request")
        end
    end
    
    def send_confirmation(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        attachments['image.png'] = @request.image.url if @request.image?
        
        mail(to: @request.client_email, subject: "Your request has been submitted!")
    end
    
    def send_welcome_email(promoter)
        @promoter = promoter
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: "Welcome to MyRates!")
        end
    end
end
