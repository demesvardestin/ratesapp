class AddPromotionTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :promotion_type, :string
  end
end
