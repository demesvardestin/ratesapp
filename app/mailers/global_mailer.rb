class GlobalMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: 'MyRates', sender: 'no-reply@myrates.co'
 
    def new_help_ticket(ticket)
        @ticket = ticket
        
        mail(to: "teammyrates@gmail.com", subject: "New Help Ticket")
    end
end
