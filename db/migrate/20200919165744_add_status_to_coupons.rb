class AddStatusToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :status, :boolean
  end
end
