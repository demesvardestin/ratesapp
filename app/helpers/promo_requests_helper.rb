module PromoRequestsHelper
    
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
