class AddClaimedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :claimed, :boolean, default: false
    add_column :users, :username, :string
    add_column :users, :followed_by, :string
    add_column :users, :follows, :string
    add_column :users, :post_count, :integer
  end
end
