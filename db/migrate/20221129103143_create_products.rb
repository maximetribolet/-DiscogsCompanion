class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :media_format
      t.string :album_title
      t.string :artist
      t.string :release_date
      t.string :genre
      t.float :lowest_price
      t.float :median_price
      t.string :product_url
      t.string :image_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
