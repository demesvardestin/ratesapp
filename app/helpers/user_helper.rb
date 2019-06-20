module UserHelper
    def shorten(number)
        number = number.split(" ").map do |i|
            if i.to_i != 0
                i
            else
                case i
                when "Thousand"
                    "K"
                else
                    "M"
                end
            end
        end.join("")
    end
    
    def payment_status_color(status)
        case status.downcase
        when "unpaid"
            "#dc3545"
        when "paid"
            "#28a745"
        end
    end
    
    def theme_color_options
        ["#004085", "#85D8CE", "#155724",
        "linear-gradient(to right, #0f2027, #203a43, #2c5364)",
        "linear-gradient(to right, #f12711, #f5af19)",
        "linear-gradient(to right, #ad5389, #3c1053)",
        "linear-gradient(to right, #00b09b, #96c93d)"]
    end
    
    def platforms
        ["Instagram", "Twitter", "Facebook", "Soundcloud"]
    end
    
    def stripe_last_4
        Stripe::Account.retrieve(current_user.stripe_token)
        .external_accounts.data.first['last4']
    end
    
    def card_brand
        Stripe::Account.retrieve(current_user.stripe_token)
        .external_accounts.data.first['brand']
    end
    
    def promos_sold_for(period)
        case period.downcase
        when 'day'
            current_user.promo_requests.day
        when 'week'
            current_user.promo_requests.week
        when 'month'
            current_user.promo_requests.month
        when 'year'
            current_user.promo_requests.year
        else
            current_user.promo_requests.year
        end
    end
    
    def earnings_for(period)
        number_to_currency promos_sold_for(period).map(&:promo).sum(&:package_price_to_float)
    end
    
    def promotion_types
        ["Anything", "Music", "Fashion", "Food", "Haircare", "Skincare", "Fitness", "Religion", "Other"]
    end
end
