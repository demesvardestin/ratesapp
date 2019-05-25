class GlobalMailer < ApplicationMailer
    add_template_helper(ApplicationHelper)
    default from: "MyRates <no-reply@myrates.co>"
    default sender: 'MyRates'
    default reply_to: 'teammyrates@gmail.com'
    default unsubscribe: 'https://myrates.herokuapp.com/account/settings'
 
    def new_help_ticket(ticket)
        @ticket = ticket
        
        mail(to: "teammyrates@gmail.com", subject: "New Help Ticket")
    end
end
