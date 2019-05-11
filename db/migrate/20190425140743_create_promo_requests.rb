class CreatePromoRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :promo_requests do |t|
      t.integer :brand_id
      t.boolean :approved, default: false
      t.boolean :first_check_passed, default: false
      t.boolean :second_check_passed, default: false
      t.boolean :third_check_passed, default: false
      t.boolean :in_escrow, default: false
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
