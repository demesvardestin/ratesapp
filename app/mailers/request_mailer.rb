class RequestMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: "MyRates <no-reply@myrates.co>"
    default sender: 'MyRates'
    default reply_to: 'teammyrates@gmail.com'
    default unsubscribe: 'myrates.co/account/settings'
 
    def send_request(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        attachments['image.png'] = @request.image.url if @request.image?
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: "You have a new request")
        end
    end
    
    def send_payment_receipt_to_client(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        
        mail(to: @request.client_email, subject: "Payment Notice For Your MyRates Request")
    end
    
    def send_payment_receipt_to_promoter(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: "Payout Notice For Request #{@request.token}")
        end
    end
    
    def send_stripe_alert_to(promoter, subject, body=nil)
        @promoter = promoter
        @body = body
        
        unless @promoter.unsubscribed_from_email
            mail(to: @promoter.email, subject: subject)
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
