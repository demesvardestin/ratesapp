class AddStripeTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_token, :string
    add_column :users, :image, :string
  end
end
