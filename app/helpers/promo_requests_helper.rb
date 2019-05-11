module PromoRequestsHelper
    
    def pretty_display(text, link=false)
        if !text.empty?
            if !link
                text
            else
                html = <<-html
                    <a href="#{text}" target="_blank">
                        #{text}
                    </a>
                html
                
                raw html
            end
        else
            "N/A"
        end
    end
    
    def request_status_color(status)
        case status.downcase
        when "pending"
            "secondary"
        when "denied"
            "danger"
        when "accepted"
            "success"
        end
    end
    
end
