class PromoRequest < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :image, file_size: { less_than: 5.megabytes }
    
    belongs_to :promo
    # belongs_to :brand, :dependent => :destroy
    scope :unseen, -> { where.not(seen: true) }
    
    before_create :generate_token
    
    module RandomToken
        def self.random(len=28, character_set = ["A".."Z", "a".."z", "0".."9"])
            chars = character_set.map{|x| x.is_a?(Range) ? x.to_a : x }.flatten
            Array.new(len){ chars.sample }.join
        end
    end
    
    def unseen
        !seen
    end
    
    def status
        if approved
            if first_check_passed
                "Content Posted"
            elsif second_check_passed
                "Promotion in progress"
            elsif third_check_passed
                "Promotion completed!"
            else
                "Approved"
            end
        elsif approved.nil?
            "Pending Approval"
        else
            "Request denied"
        end
    end
    
    def status_level
        case status
        when "Approved"
            "40"
        when "Content Posted"
            "60"
        when "Promotion in progress"
            "80"
        when "Promotion completed!"
            "100"
        else
            "20"
        end
    end
    
    def status_meaning
        case status
        when "Approved"
            """
            Your request has been approved. Your card has been debitted
            $#{promo.package_price} and #{promo.user.username} will be posting
            your content soon.
            """
        when "Content Posted"
            """
            Your content has been posted. Head over to #{promo.user.username}'s
            Instagram account to view it.
            """
        when "Promotion in progress"
            """
            This is just to let you know that your promotion is currently in progress.
            """
        when "Promotion completed!"
            """
            Your promotion has been successfully completed! Hope you're satisfied
            with the results. If you have any question, please reach out to
            #{promo.user.username} directly on here, on independently via
            instagram DM.
            """
        when "Request denied"
            """
            #{promo.user.username} has denied your request. Please reach out to
            them for any question regarding this decision.
            """
        else
            """
            Your request is pending approval from #{promo.user.username}. Once
            they accept, you can expect your content to be promoted shortly after.
            """
        end
    end
    
    protected
    
    def generate_token
        token = RandomToken.random
        
        until !PromoRequest.exists?(token: token)
          generate_token
        end
        
        self.token = token
    end
    
end
