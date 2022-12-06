class AddFormatToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :media_format, :string
    add_column :alerts, :discogs_id, :string
  end
end
