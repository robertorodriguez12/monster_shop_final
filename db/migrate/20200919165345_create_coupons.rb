class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :percent

      t.timestamps
    end
  end
end
