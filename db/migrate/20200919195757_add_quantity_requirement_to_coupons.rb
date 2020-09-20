class AddQuantityRequirementToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :quantity_requirement, :integer
  end
end
