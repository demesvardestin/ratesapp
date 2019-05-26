class PromoRequest < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :image, file_size: { less_than: 5.megabytes }
    
    belongs_to :promo
    
    scope :unseen, -> { where.not(seen: true) }
    scope :seen, -> { where(seen: true) }
    scope :incomplete, -> { where.not(complete: true) }
    scope :completed, -> { where(complete: true) }
    
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
    
    def payment_status
        paid ? "Paid" : "Unpaid"
    end
    
    def completion_status
        complete ? "processed" : "unprocessed"
    end
    
    def created_at_time
        created_at - 4.hour
    end
    
    def self.send_email(request_)
        RequestMailer.send_request(request_).deliver_now 
    end
    
    protected
    
    def generate_token
        token = RandomToken.random(8)
        
        until !PromoRequest.exists?(token: token)
          generate_token
        end
        
        self.token = token
    end
    
end
