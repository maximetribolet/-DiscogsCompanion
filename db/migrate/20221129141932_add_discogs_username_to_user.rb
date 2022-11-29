class AddDiscogsUsernameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :discogs_username, :string
  end
end
