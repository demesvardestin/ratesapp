module ApplicationHelper
    def navbar
        if current_user
            "layouts/promoter_navbar"
        else
            "layouts/base_navbar"
        end
    end
    
    def request_count
        requests.count
    end
    
    def requests
        current_user.promo_requests.unseen
    end
    
    def display_if_notifications_unchecked
        current_user.notification_watcher.checked ? 'hide' : ''
    end
    
    def background_color_for_notification(req)
        if req.seen
            'background-transparent'
        else
            'cyan-background'
        end
    end
    
    def package_types
        ["Basic", "Bronze", "Silver", "Gold", "Platinum"]
    end
end
