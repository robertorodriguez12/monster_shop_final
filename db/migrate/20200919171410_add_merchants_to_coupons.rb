class AddMerchantsToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_reference :coupons, :merchant, foreign_key: true
  end
end
