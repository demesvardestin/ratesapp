class CreatePromoRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :promo_requests do |t|
      t.integer :user_id
      t.boolean :approved
      t.boolean :in_escrow, default: false
      t.boolean :paid, default: false
      t.integer :promo_id
      t.string :image
      t.string :video_link, default: ""
      t.string :audio_link, default: ""
      t.string :website_link, default: ""
      t.text :caption, default: ""
      t.string :hashtags, default: ""
      t.text :additional_notes, default: ""
      t.string :token
      t.boolean :cancelled, default: false
      t.string :client_email, default: ""

      t.timestamps
    end
  end
end
