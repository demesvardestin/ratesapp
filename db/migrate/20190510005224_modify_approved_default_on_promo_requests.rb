class ModifyApprovedDefaultOnPromoRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :promo_requests, :approved, :boolean
    add_column :promo_requests, :approved, :boolean
  end
end
