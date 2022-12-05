class AddFormatToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :media_format, :string
  end
end
