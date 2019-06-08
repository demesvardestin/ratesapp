class AddStripeExternalAccountVerifiedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_external_account_verified, :boolean, default: false
    add_column :promo_requests, :direct_payment, :boolean
  end
end
