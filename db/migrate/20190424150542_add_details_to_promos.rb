class AddDetailsToPromos < ActiveRecord::Migration[5.0]
  def change
    add_column :promos, :user_id, :integer
    add_column :promos, :brand_id, :integer
  end
end
