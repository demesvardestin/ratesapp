class AddMoreDetailsToPromoRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :promo_requests, :promo_id, :integer
    add_column :promo_requests, :seen, :boolean, default: false
  end
end
