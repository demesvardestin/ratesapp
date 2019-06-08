class AddPreferredPayoutMethodToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preferred_payout_method, :string
    add_column :promo_requests, :stripe_charge_id, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :stripe_account_verified, :boolean, default: false
  end
end
