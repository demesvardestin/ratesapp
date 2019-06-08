class PromoRequest < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :image, file_size: { less_than: 5.megabytes }
    
    belongs_to :promo
    
    scope :unseen, -> { where.not(seen: true) }
    scope :seen, -> { where(seen: true) }
    scope :incomplete, -> { where.not(complete: true) }
    scope :completed, -> { where(complete: true) }
    scope :paid, -> { where(paid: true) }
    scope :day, -> { where(created_at: DateTime.now.at_beginning_of_day.utc..Time.now.utc) }
    scope :week, -> { where(created_at: DateTime.now.at_beginning_of_week.utc..Time.now.utc) }
    scope :last_week, -> { where(created_at: DateTime.now.at_beginning_of_week.last_week.utc..DateTime.now.at_end_of_week.last_week.utc) }
    scope :two_weeks_ago, -> { where(created_at: DateTime.now.at_beginning_of_week.last_week.last_week.utc..DateTime.now.at_end_of_week.last_week.last_week.utc) }
    scope :month, -> { where(created_at: DateTime.now.at_beginning_of_month.utc..Time.now.utc) }
    scope :year, -> { where(created_at: DateTime.now.at_beginning_of_year.utc..Time.now.utc) }
    
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
    
    def price
        promo.package_price.package_price_to_float
    end
    
    def payment_method
        "Cashapp or Paypal"
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
