class AddAdditionalDetailsToPromoRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :promo_requests, :complete, :boolean, default: false
    add_column :promo_requests, :social_platform, :string
    add_column :promo_requests, :shipped, :boolean, default: false
    add_column :users, :theme_color, :string, default: "#eef3f5"
    add_column :users, :background_image, :string
  end
end
