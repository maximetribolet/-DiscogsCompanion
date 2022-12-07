class AddCurrencyToMatch < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :currency, :string
  end
end
