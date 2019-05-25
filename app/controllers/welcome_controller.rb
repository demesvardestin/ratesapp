class WelcomeController < ApplicationController
    def help
        @ticket = HelpTicket.new
    end
end