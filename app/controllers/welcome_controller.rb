class WelcomeController < ApplicationController
    require 'contact_form.rb'
    skip_before_action :verify_authenticity_token, only: :submit_help_ticket
    
    def submit_help_ticket
        c = ContactForm.new(contact_form_params)
        c.deliver
        
        redirect_to pages_help_path(:submitted => true),
            notice: "Your request has been submitted. We will be in touch with you shortly!"
    end
    
    private
    
    def contact_form_params
        params.permit(:name, :email, :subject, :message)
    end
end