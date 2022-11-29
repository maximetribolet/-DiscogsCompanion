class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :discogs_username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :telephone, :string
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :postcode, :string
  end
end
