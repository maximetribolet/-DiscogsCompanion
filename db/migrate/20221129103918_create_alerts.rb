class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :min_media_condition
      t.string :min_sleeve_condition
      t.string :country
      t.string :max_price
      t.boolean :auto_buy
      t.integer :alert_duration_days
      t.float :seller_rating
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
