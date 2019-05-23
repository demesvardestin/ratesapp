class AddStripeTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_token, :string
    add_column :users, :image, :string
    add_column :promos, :package_price, :string
    add_column :promos, :package_details, :text, default: ""
    add_column :promo_requests, :seen, :boolean, default: false
  end
end
