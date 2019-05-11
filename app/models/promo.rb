class Promo < ApplicationRecord
    belongs_to :user, :dependent => :destroy
    has_many :promo_requests
    scope :sorted, -> { self.all.sort_by(&:package_price_to_int) }
    
    def package_price_to_int
        package_price.to_i
    end
end
