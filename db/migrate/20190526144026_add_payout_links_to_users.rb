class AddPayoutLinksToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :paypal_link, :string
    add_column :users, :cashapp_link, :string
  end
end
