class RequestMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: 'team@promoin.bio'
 
    def send_request(promo_request)
        @request = promo_request
        @promoter = @request.promo.user
        
        mail(to: @promoter.email, from: "The PromoinBio Team", subject: 'You have a new promotion request!')
    end
    
    def send_welcome_email(promoter)
        @promoter = promoter
        
        mail(to: @promoter.email, from: "The Promoinbio Team", subject: "Welcome to Promoinbio!")
    end
end
