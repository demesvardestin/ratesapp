module ApplicationHelper
    def navbar
        if current_user
            "layouts/promoter_navbar"
        else
            "layouts/base_navbar"
        end
    end
    
    def body
        if current_user
            "layouts/promoter_body"
        else
            "layouts/base_body"
        end
    end
    
    def footer
        if current_user
            "layouts/promoter_footer"
        else
            "layouts/base_footer"
        end
    end
    
    def request_count
        if requests.present?
            requests.unseen.count
        else
            0
        end
    end
    
    def requests
        current_user.promo_requests
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
    
    def page_name
        return "" if request.path_info == "/"
        " | " + request.path_info.split('/').map(&:capitalize).join(' ')
    end
    
    def help_topics
        ["I'm not receiving emails", "I'm having trouble logging into my account",
            "I'm getting spammed", "Other"]
    end
end
