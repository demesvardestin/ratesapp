class RequestMailer < ApplicationMailer
    default from: 'request@buypromo.co'
 
    def send_request(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        
        mail(to: @promoter.email, subject: 'New Promo Request')
    end
end
