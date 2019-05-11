class Brand < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :promo_requests
  has_many :comments
  
  def is_client_of(promoter)
    promoter.promo_requests.map(&:brand).include? self
  end
end
