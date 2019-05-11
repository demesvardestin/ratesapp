class AddFurtherDetailsToPromoRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :promo_requests, :image, :string
    add_column :promo_requests, :video_link, :string, default: ""
    add_column :promo_requests, :audio_link, :string, default: ""
    add_column :promo_requests, :website_link, :string, default: ""
    add_column :promo_requests, :caption, :text, default: ""
    add_column :promo_requests, :hashtags, :string, default: ""
    add_column :promo_requests, :additional_notes, :text, default: ""
    add_column :promo_requests, :token, :string
    add_column :promo_requests, :cancelled, :boolean, default: false
    add_column :promo_requests, :client_email, :string, default: ""
  end
end
