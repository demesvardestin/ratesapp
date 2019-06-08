class Promo < ApplicationRecord
    belongs_to :user
    has_many :promo_requests
    scope :sorted, -> { self.all.sort_by(&:package_price_to_int) }
    
    def package_price_to_int
        package_price.to_i
    end
    
    def package_price_to_float
        package_price.to_f
    end
end
