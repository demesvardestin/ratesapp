class AddPackageDetailsToPromos < ActiveRecord::Migration[5.0]
  def change
    add_column :promos, :package_type, :string, default: 'basic'
    add_column :promos, :package_price, :string, default: '0.00'
    add_column :promos, :package_details, :text, default: ''
  end
end
