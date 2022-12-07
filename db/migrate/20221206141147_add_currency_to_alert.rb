class AddCurrencyToAlert < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :currency, :string
  end
end
