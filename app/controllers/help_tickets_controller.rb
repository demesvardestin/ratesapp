class HelpTicketsController < ApplicationController
    def create
        @ticket = HelpTicket.new(help_ticket_params)
        
        respond_to do |format|
            if @ticket.save
                format.html {
                    redirect_to pages_help_path(:submitted => true),
                    notice: "Your request has been submitted. We will be in touch with you shortly!"
                }
                
                GlobalMailer.new_help_ticket(@ticket).deliver_now
            else
                format.html { redirect_to pages_help_path, notice: "An error occurred, please submit your form again." }
            end
        end
    end
    
    private
    
    def help_ticket_params
        params.require(:help_ticket).permit(:email, :content)
    end
end